import { test, expect } from '@playwright/test';

test('test', async ({ page }) => {
  // ベースURLを使用する（CI環境では環境変数から設定される）
  await page.goto('/');
  await expect(page).toHaveScreenshot('screenshot.png');
});