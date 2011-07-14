import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.content.Context;

public class ScreenLock {
  PowerManager pm;
  Context context;
  WakeLock wl;

  public ScreenLock() {
    pm =(PowerManager) getSystemService(Context.POWER_SERVICE);
    wl = pm.newWakeLock(PowerManager.SCREEN_DIM_WAKE_LOCK, "My Tag");
  }

  public void start() {
    wl.acquire();
  }

  public void stop() {
    wl.release();
  }
}

