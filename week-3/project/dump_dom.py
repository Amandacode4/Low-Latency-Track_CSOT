import asyncio
from playwright.async_api import async_playwright

async def main():
    async with async_playwright() as p:
        browser = await p.chromium.launch_persistent_context(
            './playwright_session', 
            headless=True
        )
        page = await browser.new_page()
        await page.goto("https://csot-low-latency.devclub.in")
        await page.wait_for_selector('text="Your submissions"', timeout=10000)
        html = await page.content()
        with open('dom.html', 'w') as f:
            f.write(html)
        await browser.close()

if __name__ == "__main__":
    asyncio.run(main())
