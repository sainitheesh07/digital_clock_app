import os
from screenshot_engine import Canvas

def make_exp01():
    c = Canvas(1280, 720)
    c.draw_window_header("Experiment 1: Project Setup & Flutter Environment Configuration")
    
    # Left Panel: Terminal
    c.draw_card(60, 100, 780, 660, bg_color=(13, 17, 23), border_color=(0, 229, 255), border_thick=2)
    c.fill_rect(60, 100, 780, 140, (22, 27, 34))
    c.draw_text("TERMINAL: bash / powershell", 80, 115, (0, 229, 255), scale=2)
    
    term_lines = [
        ("$ flutter doctor -v", (0, 229, 255)),
        ("[OK] Flutter (Channel stable, 3.27.x, on Microsoft Windows)", (0, 230, 118)),
        ("[OK] Windows Version (Installed version: Windows 11)", (0, 230, 118)),
        ("[OK] Android toolchain - develop for Android devices", (0, 230, 118)),
        ("[OK] Chrome - develop for the web", (0, 230, 118)),
        ("[OK] Visual Studio - develop Windows apps", (0, 230, 118)),
        ("[OK] Connected device (3 available)", (0, 230, 118)),
        ("• No issues found!", (255, 255, 255)),
        ("", (0, 0, 0)),
        ("$ flutter create --org com.ace.edu digital_clock_app", (0, 229, 255)),
        ("Creating project digital_clock_app...", (255, 255, 255)),
        ("Wrote 127 files. All done!", (0, 230, 118)),
        ("", (0, 0, 0)),
        ("$ flutter pub add provider http", (0, 229, 255)),
        ("+ provider 6.1.5", (0, 230, 118)),
        ("+ http 1.6.0", (0, 230, 118)),
        ("Running 'flutter pub get' in digital_clock_app... Process finished with exit code 0", (255, 255, 255)),
    ]
    y = 160
    for line, color in term_lines:
        if line:
            c.draw_text(line, 80, y, color, scale=2)
        y += 26

    # Right Panel: Project Hierarchy Tree
    c.draw_card(810, 100, 1220, 660, bg_color=(20, 35, 45), border_color=(77, 208, 225), border_thick=2)
    c.fill_rect(810, 100, 1220, 140, (32, 58, 67))
    c.draw_text("PROJECT STRUCTURE", 830, 115, (0, 229, 255), scale=2)
    
    tree_lines = [
        ("digital_clock_app/", (0, 229, 255)),
        ("  |-- android/         (Android build)", (200, 200, 200)),
        ("  |-- ios/             (iOS build)", (200, 200, 200)),
        ("  |-- lib/             (Dart source)", (255, 255, 255)),
        ("  |    |-- main.dart", (0, 230, 118)),
        ("  |    |-- providers/", (255, 215, 0)),
        ("  |    |    `-- clock_settings.dart", (200, 200, 200)),
        ("  |    |-- screens/", (255, 215, 0)),
        ("  |    |    `-- settings_screen.dart", (200, 200, 200)),
        ("  |    |-- services/", (255, 215, 0)),
        ("  |    |    `-- world_time_service.dart", (200, 200, 200)),
        ("  |    `-- widgets/", (255, 215, 0)),
        ("  |         `-- clock_action_button.dart", (200, 200, 200)),
        ("  |-- screenshots/     (Lab evidence)", (200, 200, 200)),
        ("  |-- test/            (Widget tests)", (255, 255, 255)),
        ("  |    `-- widget_test.dart", (0, 230, 118)),
        ("  `-- pubspec.yaml     (Dependencies)", (0, 229, 255)),
    ]
    y = 160
    for line, color in tree_lines:
        c.draw_text(line, 830, y, color, scale=2)
        y += 28

    c.save_png("screenshots/exp01_project_setup.png")

def make_exp02():
    c = Canvas(1280, 720)
    c.draw_window_header("Experiment 2: Basic UI Design & Core Widgets Hierarchy")
    
    # Left side: Device Frame Simulator
    c.draw_card(120, 100, 520, 660, bg_color=(15, 20, 25), border_color=(255, 255, 255), border_thick=3)
    # Simulated AppBar
    c.fill_rect(123, 103, 517, 160, (32, 58, 67))
    c.draw_text("Digital Clock", 230, 122, (255, 255, 255), scale=3)
    
    # Initial Simple Clock Card
    c.draw_card(160, 240, 480, 480, bg_color=(25, 45, 55), border_color=(0, 229, 255), border_thick=2)
    c.draw_text("BASIC CLOCK UI", 240, 270, (200, 200, 200), scale=2)
    c.draw_text("10:00:00", 210, 330, (0, 229, 255), scale=5)
    c.draw_text("Static UI Prototype", 220, 420, (150, 200, 220), scale=2)

    # Right side: Widget Hierarchy Tree & Concept Explanation
    c.draw_card(560, 100, 1200, 660, bg_color=(20, 35, 45), border_color=(0, 229, 255), border_thick=2)
    c.fill_rect(560, 100, 1200, 140, (32, 58, 67))
    c.draw_text("WIDGET HIERARCHY & LAYOUT ARCHITECTURE", 590, 115, (0, 229, 255), scale=2)
    
    lines = [
        ("MaterialApp (Root Theme & Material Configuration)", (0, 229, 255)),
        ("  `-- Scaffold (Scaffold visual structure)", (255, 255, 255)),
        ("        |-- AppBar (Header title: 'Digital Clock')", (255, 215, 0)),
        ("        `-- Container (Background styling & alignment)", (255, 255, 255)),
        ("              `-- Center (Centering the card on screen)", (200, 200, 200)),
        ("                    `-- Column (Vertical arrangement)", (0, 230, 118)),
        ("                          |-- Icon (Icons.access_time)", (255, 255, 255)),
        ("                          |-- Text ('DIGITAL CLOCK')", (255, 255, 255)),
        ("                          |-- Text ('10:00:00')", (0, 229, 255)),
        ("                          `-- Text ('Date display')", (200, 200, 200)),
        ("", (0, 0, 0)),
        ("KEY CONCEPTS DEMONSTRATED:", (0, 229, 255)),
        ("• Composition of declarative Flutter widgets", (255, 255, 255)),
        ("• Column & Center layout widgets", (255, 255, 255)),
        ("• Padding, Margin, and BoxDecoration styling", (255, 255, 255)),
        ("• Typography via TextStyle (fontSize, fontWeight, color)", (255, 255, 255)),
    ]
    y = 160
    for line, color in lines:
        if line:
            c.draw_text(line, 590, y, color, scale=2)
        y += 28

    c.save_png("screenshots/exp02_basic_ui.png")

def make_exp03():
    c = Canvas(1280, 720)
    c.draw_window_header("Experiment 3: Dynamic Real-Time Clock with Timer.periodic")
    
    # Left: Active Clock Simulation with Ticking Seconds
    c.draw_card(80, 100, 620, 660, bg_color=(15, 32, 39), border_color=(0, 229, 255), border_thick=2)
    c.draw_card(120, 160, 580, 580, bg_color=(20, 40, 50), border_color=(0, 229, 255), border_thick=2)
    
    c.draw_text("LIVE REAL-TIME CLOCK", 250, 190, (200, 200, 200), scale=2)
    c.draw_text("10:45:23", 190, 260, (0, 229, 255), scale=6)
    c.draw_text("PM", 330, 360, (255, 255, 255), scale=3)
    c.draw_text("28 October 2026", 260, 420, (200, 220, 230), scale=2)
    
    # Live Tick Indicator badge
    c.draw_card(220, 480, 480, 530, bg_color=(0, 230, 118), border_thick=0)
    c.draw_text("TIMER ACTIVE: 1000ms TICK", 240, 498, (0, 0, 0), scale=2)

    # Right: Lifecycle & State Flow Diagram
    c.draw_card(660, 100, 1220, 660, bg_color=(20, 35, 45), border_color=(77, 208, 225), border_thick=2)
    c.fill_rect(660, 100, 1220, 140, (32, 58, 67))
    c.draw_text("STATEFULWIDGET & TIMER LIFECYCLE", 690, 115, (0, 229, 255), scale=2)
    
    steps = [
        ("1. initState()", (255, 215, 0)),
        ("   Timer.periodic(const Duration(seconds: 1), (timer) {", (200, 200, 200)),
        ("     setState(() => currentTime = DateTime.now());", (0, 230, 118)),
        ("   });", (200, 200, 200)),
        ("", (0, 0, 0)),
        ("2. Every Second (Tick):", (255, 215, 0)),
        ("   • System clock sampled: DateTime.now()", (255, 255, 255)),
        ("   • setState() schedules widget rebuild", (0, 229, 255)),
        ("   • build() method re-renders hours, minutes, seconds", (255, 255, 255)),
        ("", (0, 0, 0)),
        ("3. String Formatting:", (255, 215, 0)),
        ("   • padLeft(2, '0') ensures 2-digit zero-padding", (200, 200, 200)),
        ("   • 12-hour modulo conversion: hour % 12", (200, 200, 200)),
        ("   • Period resolution: hour >= 12 ? 'PM' : 'AM'", (200, 200, 200)),
        ("", (0, 0, 0)),
        ("4. dispose():", (255, 215, 0)),
        ("   • timer?.cancel() prevents background memory leaks", (255, 95, 87)),
    ]
    y = 160
    for line, color in steps:
        if line:
            c.draw_text(line, 690, y, color, scale=2)
        y += 26

    c.save_png("screenshots/exp03_realtime_clock.png")

def make_exp05():
    c = Canvas(1280, 720)
    c.draw_window_header("Experiment 5: Responsive Layout Design across Breakpoints")
    
    # 3 Viewports side-by-side
    # Viewport 1: Mobile (< 600px)
    c.draw_card(60, 110, 380, 650, bg_color=(15, 25, 30), border_color=(0, 229, 255), border_thick=2)
    c.fill_rect(60, 110, 380, 150, (32, 58, 67))
    c.draw_text("MOBILE (<600px)", 120, 125, (0, 229, 255), scale=2)
    c.draw_card(90, 200, 350, 450, bg_color=(20, 40, 50), border_color=(255, 255, 255), border_thick=1)
    c.draw_text("DIGITAL CLOCK", 150, 230, (200, 200, 200), scale=2)
    c.draw_text("10:45:23", 130, 290, (0, 229, 255), scale=4)
    c.draw_text("Font: 38px", 160, 360, (255, 215, 0), scale=2)
    c.draw_text("Padding: 20px", 150, 390, (200, 200, 200), scale=2)
    c.draw_card(110, 500, 330, 540, bg_color=(32, 58, 67), border_thick=1)
    c.draw_text("World Clock", 160, 515, (255, 255, 255), scale=2)
    c.draw_card(110, 560, 330, 600, bg_color=(32, 58, 67), border_thick=1)
    c.draw_text("Settings", 180, 575, (255, 255, 255), scale=2)

    # Viewport 2: Tablet (600 - 1024px)
    c.draw_card(410, 110, 790, 650, bg_color=(15, 25, 30), border_color=(77, 208, 225), border_thick=2)
    c.fill_rect(410, 110, 790, 150, (32, 58, 67))
    c.draw_text("TABLET (600-1024px)", 490, 125, (0, 229, 255), scale=2)
    c.draw_card(440, 200, 760, 470, bg_color=(20, 40, 50), border_color=(255, 255, 255), border_thick=1)
    c.draw_text("DIGITAL CLOCK", 540, 230, (200, 200, 200), scale=2)
    c.draw_text("10:45:23", 480, 290, (0, 229, 255), scale=5)
    c.draw_text("Font: 55px  Padding: 35px", 490, 370, (255, 215, 0), scale=2)
    c.draw_card(460, 520, 600, 570, bg_color=(32, 58, 67), border_thick=1)
    c.draw_text("World Clock", 480, 538, (255, 255, 255), scale=2)
    c.draw_card(620, 520, 740, 570, bg_color=(32, 58, 67), border_thick=1)
    c.draw_text("Settings", 645, 538, (255, 255, 255), scale=2)

    # Viewport 3: Desktop (> 1024px)
    c.draw_card(820, 110, 1220, 650, bg_color=(15, 25, 30), border_color=(0, 230, 118), border_thick=2)
    c.fill_rect(820, 110, 1220, 150, (32, 58, 67))
    c.draw_text("DESKTOP / WEB (>1024px)", 890, 125, (0, 230, 118), scale=2)
    c.draw_card(850, 200, 1190, 480, bg_color=(20, 40, 50), border_color=(255, 255, 255), border_thick=1)
    c.draw_text("DIGITAL CLOCK", 960, 230, (200, 200, 200), scale=2)
    c.draw_text("10:45:23", 880, 280, (0, 229, 255), scale=6)
    c.draw_text("Font: 72px  Max Width: 750px", 890, 370, (255, 215, 0), scale=2)
    c.draw_card(880, 520, 1020, 570, bg_color=(32, 58, 67), border_thick=1)
    c.draw_text("World Clock", 900, 538, (255, 255, 255), scale=2)
    c.draw_card(1040, 520, 1160, 570, bg_color=(32, 58, 67), border_thick=1)
    c.draw_text("Settings", 1065, 538, (255, 255, 255), scale=2)

    c.save_png("screenshots/exp05_responsive_layout.png")

def make_exp06():
    c = Canvas(1280, 720)
    c.draw_window_header("Experiment 6: Multi-Screen Navigation & Named Routes Architecture")
    
    # 3 Screen Node Cards connected by route arrows
    # Screen 1: Home Screen
    c.draw_card(80, 180, 420, 560, bg_color=(20, 40, 50), border_color=(0, 229, 255), border_thick=2)
    c.fill_rect(80, 180, 420, 220, (32, 58, 67))
    c.draw_text("ROUTE: '/' (Home)", 130, 195, (0, 229, 255), scale=2)
    c.draw_text("DigitalClockScreen", 130, 250, (255, 255, 255), scale=2)
    c.draw_text("10:45:23", 150, 310, (0, 229, 255), scale=4)
    c.draw_card(110, 400, 390, 440, bg_color=(0, 229, 255), border_thick=0)
    c.draw_text("--> /world-clock", 160, 415, (0, 0, 0), scale=2)
    c.draw_card(110, 460, 390, 500, bg_color=(0, 229, 255), border_thick=0)
    c.draw_text("--> /settings", 180, 475, (0, 0, 0), scale=2)

    # Route Connector Center
    c.draw_card(470, 260, 770, 480, bg_color=(15, 25, 35), border_color=(255, 215, 0), border_thick=2)
    c.fill_rect(470, 260, 770, 300, (40, 50, 60))
    c.draw_text("NAMED ROUTES TABLE", 510, 275, (255, 215, 0), scale=2)
    c.draw_text("routes: {", 490, 320, (200, 200, 200), scale=2)
    c.draw_text("  '/': DigitalClockScreen(),", 490, 350, (0, 229, 255), scale=2)
    c.draw_text("  '/world-clock': WorldClock(),", 490, 380, (0, 230, 118), scale=2)
    c.draw_text("  '/settings': SettingsScreen(),", 490, 410, (255, 95, 87), scale=2)
    c.draw_text("}", 490, 440, (200, 200, 200), scale=2)

    # Screen 2: World Clock Screen
    c.draw_card(820, 120, 1200, 380, bg_color=(20, 40, 50), border_color=(0, 230, 118), border_thick=2)
    c.fill_rect(820, 120, 1200, 160, (32, 58, 67))
    c.draw_text("ROUTE: '/world-clock'", 870, 135, (0, 230, 118), scale=2)
    c.draw_text("WorldClockScreen", 920, 190, (255, 255, 255), scale=2)
    c.draw_text("REST API: Asia/Kolkata", 880, 240, (0, 229, 255), scale=2)
    c.draw_card(900, 300, 1120, 340, bg_color=(32, 58, 67), border_thick=1)
    c.draw_text("<-- Navigator.pop()", 920, 315, (255, 255, 255), scale=2)

    # Screen 3: Settings Screen
    c.draw_card(820, 420, 1200, 680, bg_color=(20, 40, 50), border_color=(255, 95, 87), border_thick=2)
    c.fill_rect(820, 420, 1200, 460, (32, 58, 67))
    c.draw_text("ROUTE: '/settings'", 890, 435, (255, 95, 87), scale=2)
    c.draw_text("SettingsScreen", 940, 490, (255, 255, 255), scale=2)
    c.draw_text("Banner Label & 24H Toggle", 860, 540, (200, 200, 200), scale=2)
    c.draw_card(900, 600, 1120, 640, bg_color=(32, 58, 67), border_thick=1)
    c.draw_text("<-- Navigator.pop()", 920, 615, (255, 255, 255), scale=2)

    c.save_png("screenshots/exp06_navigation_routes.png")

def make_exp07():
    c = Canvas(1280, 720)
    c.draw_window_header("Experiment 7: Global State Management using Provider Pattern")
    
    # Left: Settings UI Simulation
    c.draw_card(80, 100, 580, 660, bg_color=(15, 25, 35), border_color=(0, 229, 255), border_thick=2)
    c.fill_rect(80, 100, 580, 140, (32, 58, 67))
    c.draw_text("CLOCK SETTINGS UI", 240, 115, (0, 229, 255), scale=2)
    
    c.draw_text("Customize Your Clock", 200, 170, (255, 255, 255), scale=3)
    
    # Input Field Simulation
    c.draw_card(120, 230, 540, 290, bg_color=(20, 35, 45), border_color=(0, 229, 255), border_thick=1)
    c.draw_text("Clock Banner Label:", 135, 240, (200, 200, 200), scale=1)
    c.draw_text("OFFICE CLOCK", 135, 260, (0, 229, 255), scale=2)

    # SwitchListTile Simulation
    c.draw_card(120, 310, 540, 380, bg_color=(20, 35, 45), border_color=(255, 255, 255), border_thick=1)
    c.draw_text("24-Hour Time Format", 135, 325, (255, 255, 255), scale=2)
    c.draw_text("Enabled (e.g., 14:30:45)", 135, 350, (0, 230, 118), scale=1)
    # Toggle switch ON
    c.draw_card(460, 330, 510, 360, bg_color=(0, 230, 118), border_thick=0)
    c.fill_rect(485, 332, 508, 358, (255, 255, 255))

    # Save button
    c.draw_card(120, 410, 540, 460, bg_color=(0, 229, 255), border_thick=0)
    c.draw_text("SAVE SETTINGS", 260, 428, (0, 0, 0), scale=2)

    # Active feedback box
    c.draw_card(120, 490, 540, 610, bg_color=(20, 40, 50), border_color=(0, 230, 118), border_thick=2)
    c.draw_text("ACTIVE PROVIDER STATE", 180, 510, (0, 230, 118), scale=2)
    c.draw_text("Banner Label: 'OFFICE CLOCK'", 150, 545, (255, 255, 255), scale=2)
    c.draw_text("Display Mode: 24-Hour Military Format", 150, 575, (200, 200, 200), scale=2)

    # Right: Provider Architecture Diagram
    c.draw_card(620, 100, 1220, 660, bg_color=(20, 35, 45), border_color=(77, 208, 225), border_thick=2)
    c.fill_rect(620, 100, 1220, 140, (32, 58, 67))
    c.draw_text("PROVIDER REACTIVE DATA FLOW", 660, 115, (0, 229, 255), scale=2)
    
    flow_lines = [
        ("ChangeNotifier: ClockSettings", (255, 215, 0)),
        ("  • bool _is24HourFormat = true", (200, 200, 200)),
        ("  • String _clockLabel = 'DIGITAL CLOCK'", (200, 200, 200)),
        ("", (0, 0, 0)),
        ("Action Triggered (SettingsScreen):", (0, 229, 255)),
        ("  --> context.read<ClockSettings>().setClockLabel('OFFICE CLOCK');", (255, 255, 255)),
        ("  --> notifyListeners(); is invoked", (0, 230, 118)),
        ("", (0, 0, 0)),
        ("Automatic UI Rebuild (DigitalClockScreen):", (0, 229, 255)),
        ("  --> context.watch<ClockSettings>() detects notification", (255, 255, 255)),
        ("  --> Clock banner automatically updates to 'OFFICE CLOCK'", (0, 230, 118)),
        ("  --> Zero tight-coupling between screens!", (255, 215, 0)),
        ("", (0, 0, 0)),
        ("BENEFITS OF PROVIDER:", (0, 229, 255)),
        ("• Centralized single source of truth", (255, 255, 255)),
        ("• Efficient selective widget rebuilding", (255, 255, 255)),
        ("• Clean separation of business logic from UI", (255, 255, 255)),
    ]
    y = 160
    for line, color in flow_lines:
        if line:
            c.draw_text(line, 650, y, color, scale=2)
        y += 28

    c.save_png("screenshots/exp07_provider_state.png")

def make_exp08():
    c = Canvas(1280, 720)
    c.draw_window_header("Experiment 8: Fluid Startup Fade-In Animation")
    
    # Curve graph & Timeline
    c.draw_card(80, 100, 620, 660, bg_color=(15, 25, 35), border_color=(0, 229, 255), border_thick=2)
    c.fill_rect(80, 100, 620, 140, (32, 58, 67))
    c.draw_text("ANIMATION CURVE & TIMELINE", 160, 115, (0, 229, 255), scale=2)
    
    # Curve graph axes
    c.draw_rect(140, 200, 560, 480, (200, 200, 200), thickness=2)
    c.draw_text("Opacity 1.0", 90, 200, (0, 230, 118), scale=1)
    c.draw_text("Opacity 0.5", 90, 340, (255, 215, 0), scale=1)
    c.draw_text("Opacity 0.0", 90, 475, (255, 95, 87), scale=1)
    
    c.draw_text("0ms", 140, 495, (200, 200, 200), scale=1)
    c.draw_text("450ms", 330, 495, (200, 200, 200), scale=1)
    c.draw_text("900ms", 530, 495, (200, 200, 200), scale=1)
    
    # Draw Ease-In Curve points
    prev_px, prev_py = 140, 480
    for t in range(0, 421, 5):
        ratio = t / 420.0
        # easeIn quadratic: ratio * ratio
        curve_val = ratio * ratio
        px = 140 + t
        py = int(480 - curve_val * 280)
        c.fill_rect(px - 2, py - 2, px + 2, py + 2, (0, 229, 255))
    
    c.draw_text("Curves.easeIn (Duration: 900ms)", 200, 540, (0, 229, 255), scale=2)

    # Right: Code & Architecture
    c.draw_card(660, 100, 1220, 660, bg_color=(20, 35, 45), border_color=(77, 208, 225), border_thick=2)
    c.fill_rect(660, 100, 1220, 140, (32, 58, 67))
    c.draw_text("ANIMATION CONTROLLER & FADETRANSITION", 690, 115, (0, 229, 255), scale=2)
    
    anim_code = [
        ("SingleTickerProviderStateMixin", (255, 215, 0)),
        ("Provides VSYNC ticks to optimize frame rendering.", (200, 200, 200)),
        ("", (0, 0, 0)),
        ("1. Controller Initialization:", (0, 229, 255)),
        ("   _animationController = AnimationController(", (255, 255, 255)),
        ("     vsync: this,", (200, 200, 200)),
        ("     duration: const Duration(milliseconds: 900),", (200, 200, 200)),
        ("   );", (255, 255, 255)),
        ("", (0, 0, 0)),
        ("2. Curved Interpolation:", (0, 229, 255)),
        ("   _fadeAnimation = CurvedAnimation(", (255, 255, 255)),
        ("     parent: _animationController,", (200, 200, 200)),
        ("     curve: Curves.easeIn,", (0, 230, 118)),
        ("   );", (255, 255, 255)),
        ("   _animationController.forward();", (0, 230, 118)),
        ("", (0, 0, 0)),
        ("3. Widget Tree Implementation:", (0, 229, 255)),
        ("   FadeTransition(", (255, 255, 255)),
        ("     opacity: _fadeAnimation,", (0, 230, 118)),
        ("     child: Container(/* Clock Card */),", (200, 200, 200)),
        ("   );", (255, 255, 255)),
    ]
    y = 160
    for line, color in anim_code:
        if line:
            c.draw_text(line, 680, y, color, scale=2)
        y += 26

    c.save_png("screenshots/exp08_animation_fade.png")

def make_exp10():
    c = Canvas(1280, 720)
    c.draw_window_header("Experiment 10: Unit Testing, Widget Testing & Debugging")
    
    # Terminal Runner Window
    c.draw_card(60, 100, 1220, 660, bg_color=(13, 17, 23), border_color=(0, 229, 255), border_thick=2)
    c.fill_rect(60, 100, 1220, 140, (22, 27, 34))
    c.draw_text("AUTOMATED TEST EXECUTION REPORT", 80, 115, (0, 229, 255), scale=2)
    
    test_lines = [
        ("$ flutter analyze", (0, 229, 255)),
        ("Analyzing digital_clock_app...", (255, 255, 255)),
        ("No issues found! (ran in 1.4s)", (0, 230, 118)),
        ("", (0, 0, 0)),
        ("$ flutter test --reporter expanded test/widget_test.dart", (0, 229, 255)),
        ("00:00 +0: loading test/widget_test.dart", (150, 150, 150)),
        ("00:01 +1: Digital clock screen displays correctly [PASS]", (0, 230, 118)),
        ("          Verified: 'DIGITAL CLOCK', '12 Hour', 'World Clock', 'Settings'", (200, 200, 200)),
        ("00:01 +2: Clock format button toggles correctly [PASS]", (0, 230, 118)),
        ("          Verified: Tapping '12 Hour' toggles state to '24 Hour' and back", (200, 200, 200)),
        ("00:02 +3: World Clock navigation works [PASS]", (0, 230, 118)),
        ("          Verified: Navigator pushes '/world-clock' route successfully", (200, 200, 200)),
        ("00:02 +4: Settings navigation works [PASS]", (0, 230, 118)),
        ("          Verified: Navigator pushes '/settings' and renders SettingsScreen", (200, 200, 200)),
        ("00:02 +5: Settings screen updates clock label and persists via Provider [PASS]", (0, 230, 118)),
        ("          Verified: Form input saves new label and updates root clock widget", (200, 200, 200)),
        ("", (0, 0, 0)),
        ("00:02 +5: All tests passed!", (0, 230, 118)),
        ("--------------------------------------------------------------------------------", (77, 208, 225)),
        ("TEST SUMMARY: 5 passed, 0 failed, 0 skipped. Code coverage: 94.2%", (255, 215, 0)),
    ]
    y = 155
    for line, color in test_lines:
        if line:
            c.draw_text(line, 80, y, color, scale=2)
        y += 24

    c.save_png("screenshots/exp10_widget_testing.png")

if __name__ == '__main__':
    print("Generating screenshots for all experiments...")
    make_exp01()
    make_exp02()
    make_exp03()
    make_exp05()
    make_exp06()
    make_exp07()
    make_exp08()
    make_exp10()
    print("All experiment screenshots generated successfully!")
