// Copyright (c) FIRST and other WPILib contributors.
// Open Source Software; you can modify and/or share it under the terms of
// the WPILib BSD license file in the root directory of this project.

package frc.robot;

import edu.wpi.first.networktables.ConnectionInfo;
import edu.wpi.first.networktables.NetworkTableInstance;
import edu.wpi.first.wpilibj.TimedRobot;
import edu.wpi.first.wpilibj.Timer;
import edu.wpi.first.wpilibj.smartdashboard.SmartDashboard;
import edu.wpi.first.wpilibj2.command.CommandScheduler;

public class Robot extends TimedRobot {
    
    private final RobotContainer robotContainer;
    
    private Timer periodic = new Timer();
    
    public Robot() {
        robotContainer = new RobotContainer();
    }
    
    @Override
    public void robotPeriodic() {
        CommandScheduler.getInstance().run();
    }
    
    @Override
    public void disabledInit() {
        SmartDashboard.putString("TestKey", "TestValue");
        
        periodic.reset();
        periodic.start();
    }
    @Override
    public void disabledPeriodic() {
        if(periodic.advanceIfElapsed(1)) {
            NetworkTableInstance instance = NetworkTableInstance.getDefault();
            
            ConnectionInfo[] connections = instance.getConnections();
            StringBuilder connectionsBuilder = new StringBuilder();
            if(connections.length == 0) connectionsBuilder.append("None\n");
            for (ConnectionInfo ci : connections) {
                connectionsBuilder.append(String.format("      - %s\n            Protocol: v%d.%d\n            IP: %s:%d\n", ci.remote_id, (ci.protocol_version >> 8) & 0xff, ci.protocol_version & 0xff, ci.remote_ip, ci.remote_port));
            }
            
            System.out.printf("NT Info:\n    Mode: %s\n    Connections: \n%s\n", instance.getNetworkMode().toString(), connectionsBuilder.toString());
        }
    }
    @Override
    public void disabledExit() {
        periodic.stop();
    }
    
    @Override
    public void autonomousInit() {}
    @Override
    public void autonomousPeriodic() {}
    @Override
    public void autonomousExit() {}
    
    @Override
    public void teleopInit() {}
    @Override
    public void teleopPeriodic() {}
    @Override
    public void teleopExit() {}
    
    @Override
    public void testInit() {
        CommandScheduler.getInstance().cancelAll();
    }
    @Override
    public void testPeriodic() {}
    @Override
    public void testExit() {}
    
    @Override
    public void simulationInit() {}
    @Override
    public void simulationPeriodic() {}
}
