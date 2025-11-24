import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with TickerProviderStateMixin {
  // Theme Settings
  bool _darkMode = true;
  bool _systemTheme = false;
  String _accentColor = 'Cyan';
  
  // Notification Settings
  bool _pushNotifications = true;
  bool _taskReminders = true;
  bool _dailyDigest = false;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  String _notificationTime = '09:00';
  
  // Task Settings
  bool _autoDeleteCompleted = false;
  int _autoDeleteDays = 7;
  bool _showTaskCount = true;
  bool _confirmDeletion = true;
  String _defaultPriority = 'Medium';
  String _taskSortBy = 'Date Created';
  
  // Privacy & Security
  bool _biometricLock = false;
  bool _autoLock = false;
  int _autoLockMinutes = 5;
  bool _dataBackup = true;
  
  // Advanced Settings
  bool _animationsEnabled = true;
  bool _hapticFeedback = true;
  String _dateFormat = 'DD/MM/YYYY';
  String _timeFormat = '24 Hour';
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<String> _accentColors = ['Cyan', 'Purple', 'Orange', 'Green', 'Pink'];
  final List<String> _priorities = ['Low', 'Medium', 'High', 'Critical'];
  final List<String> _sortOptions = ['Date Created', 'Priority', 'Alphabetical', 'Due Date'];
  final List<String> _dateFormats = ['DD/MM/YYYY', 'MM/DD/YYYY', 'YYYY/MM/DD'];
  final List<String> _timeFormats = ['12 Hour', '24 Hour'];
  final List<int> _autoDeleteOptions = [1, 3, 7, 14, 30];
  final List<int> _autoLockOptions = [1, 5, 10, 15, 30];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF252847),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF4facfe).withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: const Color(0xFF4facfe), size: 20),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF94a3b8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF4facfe),
            trackColor: const Color(0xFF374151),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile({
    required String title,
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: const Color(0xFF4facfe), size: 20),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1a1b3a),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF4facfe).withOpacity(0.3)),
            ),
            child: DropdownButton<String>(
              value: value,
              onChanged: onChanged,
              underline: Container(),
              dropdownColor: const Color(0xFF252847),
              style: const TextStyle(color: Colors.white),
              icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF4facfe)),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderTile({
    required String title,
    required String subtitle,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
    required String Function(double) labelFormatter,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: const Color(0xFF4facfe), size: 20),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF94a3b8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                labelFormatter(value),
                style: const TextStyle(
                  color: Color(0xFF4facfe),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF4facfe),
              inactiveTrackColor: const Color(0xFF374151),
              thumbColor: const Color(0xFF4facfe),
              overlayColor: const Color(0xFF4facfe).withOpacity(0.2),
              valueIndicatorColor: const Color(0xFF4facfe),
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required IconData icon,
    Color? iconColor,
    bool isDestructive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDestructive
                      ? const Color(0xFFff6b9d).withOpacity(0.2)
                      : const Color(0xFF4facfe).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? (isDestructive ? const Color(0xFFff6b9d) : const Color(0xFF4facfe)),
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isDestructive ? const Color(0xFFff6b9d) : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF94a3b8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: isDestructive ? const Color(0xFFff6b9d) : const Color(0xFF4facfe),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF252847),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Reset Settings',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Are you sure you want to reset all settings to default? This action cannot be undone.',
            style: TextStyle(color: Color(0xFF94a3b8)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF94a3b8)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Reset all settings to default
                setState(() {
                  _darkMode = true;
                  _systemTheme = false;
                  _pushNotifications = true;
                  _taskReminders = true;
                  _soundEnabled = true;
                  // ... reset other settings
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Settings reset to default'),
                    backgroundColor: const Color(0xFF11998e),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFff6b9d),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Reset', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1b3a),
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2d1b69), Color(0xFF1a1b3a)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4facfe)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF4facfe)),
            onPressed: _showResetDialog,
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Appearance Settings
              _buildSectionHeader('Appearance', Icons.palette_outlined),
              _buildSettingsCard(
                child: Column(
                  children: [
                    _buildSwitchTile(
                      title: 'Dark Mode',
                      subtitle: 'Use dark theme for better night viewing',
                      value: _darkMode,
                      onChanged: (value) => setState(() => _darkMode = value),
                      icon: Icons.dark_mode_outlined,
                    ),
                    _buildSwitchTile(
                      title: 'System Theme',
                      subtitle: 'Follow system appearance settings',
                      value: _systemTheme,
                      onChanged: (value) => setState(() => _systemTheme = value),
                      icon: Icons.auto_mode_outlined,
                    ),
                    _buildDropdownTile(
                      title: 'Accent Color',
                      value: _accentColor,
                      options: _accentColors,
                      onChanged: (value) => setState(() => _accentColor = value!),
                      icon: Icons.color_lens_outlined,
                    ),
                  ],
                ),
              ),

              // Notifications Settings
              _buildSectionHeader('Notifications', Icons.notifications_outlined),
              _buildSettingsCard(
                child: Column(
                  children: [
                    _buildSwitchTile(
                      title: 'Push Notifications',
                      subtitle: 'Receive task reminders and updates',
                      value: _pushNotifications,
                      onChanged: (value) => setState(() => _pushNotifications = value),
                      icon: Icons.notifications_active_outlined,
                    ),
                    _buildSwitchTile(
                      title: 'Task Reminders',
                      subtitle: 'Get reminded about due tasks',
                      value: _taskReminders,
                      onChanged: (value) => setState(() => _taskReminders = value),
                      icon: Icons.alarm_outlined,
                    ),
                    _buildSwitchTile(
                      title: 'Daily Digest',
                      subtitle: 'Daily summary of your tasks',
                      value: _dailyDigest,
                      onChanged: (value) => setState(() => _dailyDigest = value),
                      icon: Icons.today_outlined,
                    ),
                    _buildSwitchTile(
                      title: 'Sound',
                      subtitle: 'Play notification sounds',
                      value: _soundEnabled,
                      onChanged: (value) => setState(() => _soundEnabled = value),
                      icon: Icons.volume_up_outlined,
                    ),
                    _buildSwitchTile(
                      title: 'Vibration',
                      subtitle: 'Vibrate for notifications',
                      value: _vibrationEnabled,
                      onChanged: (value) => setState(() => _vibrationEnabled = value),
                      icon: Icons.vibration_outlined,
                    ),
                  ],
                ),
              ),

              // Task Management Settings
              _buildSectionHeader('Tasks', Icons.task_outlined),
              _buildSettingsCard(
                child: Column(
                  children: [
                    _buildSwitchTile(
                      title: 'Auto-delete Completed',
                      subtitle: 'Automatically remove completed tasks',
                      value: _autoDeleteCompleted,
                      onChanged: (value) => setState(() => _autoDeleteCompleted = value),
                      icon: Icons.auto_delete_outlined,
                    ),
                    if (_autoDeleteCompleted)
                      _buildSliderTile(
                        title: 'Auto-delete After',
                        subtitle: 'Days to keep completed tasks',
                        value: _autoDeleteDays.toDouble(),
                        min: 1,
                        max: 30,
                        divisions: 29,
                        onChanged: (value) => setState(() => _autoDeleteDays = value.round()),
                        labelFormatter: (value) => '${value.round()} days',
                        icon: Icons.schedule_outlined,
                      ),
                    _buildSwitchTile(
                      title: 'Show Task Count',
                      subtitle: 'Display number of tasks in app badge',
                      value: _showTaskCount,
                      onChanged: (value) => setState(() => _showTaskCount = value),
                      icon: Icons.numbers_outlined,
                    ),
                    _buildSwitchTile(
                      title: 'Confirm Deletion',
                      subtitle: 'Ask before deleting tasks',
                      value: _confirmDeletion,
                      onChanged: (value) => setState(() => _confirmDeletion = value),
                      icon: Icons.warning_outlined,
                    ),
                    _buildDropdownTile(
                      title: 'Default Priority',
                      value: _defaultPriority,
                      options: _priorities,
                      onChanged: (value) => setState(() => _defaultPriority = value!),
                      icon: Icons.priority_high_outlined,
                    ),
                    _buildDropdownTile(
                      title: 'Sort Tasks By',
                      value: _taskSortBy,
                      options: _sortOptions,
                      onChanged: (value) => setState(() => _taskSortBy = value!),
                      icon: Icons.sort_outlined,
                    ),
                  ],
                ),
              ),

              // Privacy & Security Settings
              _buildSectionHeader('Privacy & Security', Icons.security_outlined),
              _buildSettingsCard(
                child: Column(
                  children: [
                    _buildSwitchTile(
                      title: 'Biometric Lock',
                      subtitle: 'Use fingerprint or face unlock',
                      value: _biometricLock,
                      onChanged: (value) => setState(() => _biometricLock = value),
                      icon: Icons.fingerprint_outlined,
                    ),
                    _buildSwitchTile(
                      title: 'Auto Lock',
                      subtitle: 'Lock app when inactive',
                      value: _autoLock,
                      onChanged: (value) => setState(() => _autoLock = value),
                      icon: Icons.lock_clock_outlined,
                    ),
                    if (_autoLock)
                      _buildSliderTile(
                        title: 'Auto Lock Timer',
                        subtitle: 'Minutes of inactivity before lock',
                        value: _autoLockMinutes.toDouble(),
                        min: 1,
                        max: 30,
                        divisions: 29,
                        onChanged: (value) => setState(() => _autoLockMinutes = value.round()),
                        labelFormatter: (value) => '${value.round()} min',
                        icon: Icons.timer_outlined,
                      ),
                    _buildSwitchTile(
                      title: 'Data Backup',
                      subtitle: 'Automatically backup your tasks',
                      value: _dataBackup,
                      onChanged: (value) => setState(() => _dataBackup = value),
                      icon: Icons.backup_outlined,
                    ),
                  ],
                ),
              ),

              // Advanced Settings
              _buildSectionHeader('Advanced', Icons.tune_outlined),
              _buildSettingsCard(
                child: Column(
                  children: [
                    _buildSwitchTile(
                      title: 'Animations',
                      subtitle: 'Enable smooth animations',
                      value: _animationsEnabled,
                      onChanged: (value) => setState(() => _animationsEnabled = value),
                      icon: Icons.animation_outlined,
                    ),
                    _buildSwitchTile(
                      title: 'Haptic Feedback',
                      subtitle: 'Feel vibrations on interactions',
                      value: _hapticFeedback,
                      onChanged: (value) => setState(() => _hapticFeedback = value),
                      icon: Icons.vibration_outlined,
                    ),
                    _buildDropdownTile(
                      title: 'Date Format',
                      value: _dateFormat,
                      options: _dateFormats,
                      onChanged: (value) => setState(() => _dateFormat = value!),
                      icon: Icons.date_range_outlined,
                    ),
                    _buildDropdownTile(
                      title: 'Time Format',
                      value: _timeFormat,
                      options: _timeFormats,
                      onChanged: (value) => setState(() => _timeFormat = value!),
                      icon: Icons.access_time_outlined,
                    ),
                  ],
                ),
              ),

              // Action Items
              _buildSectionHeader('Actions', Icons.settings_outlined),
              _buildSettingsCard(
                child: Column(
                  children: [
                    _buildActionTile(
                      title: 'Export Data',
                      subtitle: 'Save your tasks to a file',
                      onTap: () {
                        // Implement export functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Data exported successfully'),
                            backgroundColor: const Color(0xFF11998e),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      },
                      icon: Icons.download_outlined,
                    ),
                    _buildActionTile(
                      title: 'Import Data',
                      subtitle: 'Load tasks from a backup file',
                      onTap: () {
                        // Implement import functionality
                      },
                      icon: Icons.upload_outlined,
                    ),
                    _buildActionTile(
                      title: 'Clear All Data',
                      subtitle: 'Delete all tasks and settings',
                      onTap: _showResetDialog,
                      icon: Icons.delete_forever_outlined,
                      isDestructive: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // App Version Info
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF252847).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF4facfe).withOpacity(0.1),
                  ),
                ),
                child: const Column(
                  children: [
                    Text(
                      'Todo App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        color: Color(0xFF94a3b8),
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Stay organized, stay productive',
                      style: TextStyle(
                        color: Color(0xFF4facfe),
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}