import { test, expect } from '@playwright/test';

test('test', async ({ page }) => {
  // ベースURLを使用する（CI環境では環境変数から設定される）
  await page.goto('/');
  
  // ページが完全に読み込まれるのを待つ
  await page.waitForLoadState('networkidle');
  
  // スクリーンショットのオプションを指定
  // CI環境とローカル環境の違いを吸収するための設定
  await expect(page).toHaveScreenshot('screenshot.png', {
    // アニメーションや動的なコンテンツによる差異を許容
    animations: 'disabled',
    // フォントレンダリングの違いを許容
    threshold: process.env.PLAYWRIGHT_SNAPSHOT_THRESHOLD 
      ? parseFloat(process.env.PLAYWRIGHT_SNAPSHOT_THRESHOLD) 
      : 0.1,
  });
});