import asyncio
from playwright.async_api import async_playwright
import os
import sys

async def main():
    async with async_playwright() as p:
        user_data_dir = './playwright_session'
        
        print("Launching browser...")
        # Launching with headless=False to avoid Cloudflare bot protection
        browser = await p.chromium.launch_persistent_context(
            user_data_dir, 
            headless=False
        )
        page = await browser.new_page()
        await page.goto("https://csot-low-latency.devclub.in")
        
        # Check if we need to log in
        try:
            await page.wait_for_selector('text="Your submissions"', timeout=5000)
        except:
            print("Please log in manually. Waiting for dashboard...")
            await page.wait_for_selector('text="Your submissions"', timeout=300000)
            
        print("Dashboard reached! Looking for upload mechanism...")
        
        old_top_id = None
        try:
            rows = await page.locator('tbody tr').all()
            if len(rows) > 0:
                text = await rows[0].inner_text()
                old_top_id = text.split()[0] # e.g. #2443
        except:
            pass
            
        # Print all inputs to help us debug
        inputs = await page.locator('input').all()
        for i in inputs:
            itype = await i.get_attribute('type')
            print(f"Found input of type: {itype}")
            if itype == 'file':
                print("Uploading aggregator.cpp...")
                await i.set_input_files('aggregator.cpp')
                break
        else:
            print("No file input found. Dumping DOM to help AI debug...")
            html = await page.content()
            with open('dom.html', 'w') as f:
                f.write(html)
            await browser.close()
            sys.exit(1)
            
        print("File uploaded! Waiting for judge...")
        
        # Wait for judge
        while True:
            await page.wait_for_timeout(2000)
            try:
                rows = await page.locator('tbody tr').all()
                if len(rows) > 0:
                    row_text = await rows[0].inner_text()
                    current_id = row_text.split()[0]
                    if current_id == old_top_id:
                        continue # wait for the new run to appear
                    
                    row_text_lower = row_text.lower()
                    if "running" in row_text_lower or "queued" in row_text_lower or "idle" in row_text_lower:
                        continue
                    if "correct" in row_text_lower or "incorrect" in row_text_lower:
                        print("\n--- JUDGE RESULT ---")
                        print(row_text)
                        print("--------------------")
                        break
            except Exception:
                pass

        await browser.close()

if __name__ == "__main__":
    asyncio.run(main())
