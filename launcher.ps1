Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

$projectPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectPath

$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="PHP Docker Environment"
        Width="560" Height="680"
        WindowStartupLocation="CenterScreen"
        ResizeMode="NoResize"
        WindowStyle="None"
        AllowsTransparency="True"
        Background="Transparent">

    <Window.Resources>
        <Style x:Key="ActionBtn" TargetType="Button">
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Height" Value="48"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="border" CornerRadius="10" Background="{TemplateBinding Background}" Padding="16,8">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="border" Property="Opacity" Value="0.85"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter TargetName="border" Property="Opacity" Value="0.7"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="LinkBtn" TargetType="Button">
            <Setter Property="Foreground" Value="#67e8f9"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="FontFamily" Value="Consolas"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <TextBlock x:Name="text" Text="{TemplateBinding Content}" Foreground="{TemplateBinding Foreground}" FontFamily="{TemplateBinding FontFamily}" FontSize="{TemplateBinding FontSize}"/>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="text" Property="TextDecorations" Value="Underline"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="CloseBtn" TargetType="Button">
            <Setter Property="Foreground" Value="#94a3b8"/>
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="FontSize" Value="16"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Width" Value="36"/>
            <Setter Property="Height" Value="36"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="bg" CornerRadius="18" Background="Transparent">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="bg" Property="Background" Value="#33ffffff"/>
                                <Setter Property="Foreground" Value="White"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Border CornerRadius="16" ClipToBounds="True">
        <Border.Effect>
            <DropShadowEffect BlurRadius="24" ShadowDepth="4" Opacity="0.4"/>
        </Border.Effect>
        <Border.Background>
            <LinearGradientBrush StartPoint="0,0" EndPoint="1,1">
                <GradientStop Color="#1e1b4b" Offset="0"/>
                <GradientStop Color="#0f2a4a" Offset="0.6"/>
                <GradientStop Color="#0c3547" Offset="1"/>
            </LinearGradientBrush>
        </Border.Background>

        <Grid>
            <!-- Title bar for dragging -->
            <Border x:Name="TitleBar" Height="44" VerticalAlignment="Top" Background="Transparent"/>
            <Button x:Name="BtnClose" Style="{StaticResource CloseBtn}" Content="&#x2715;" HorizontalAlignment="Right" VerticalAlignment="Top" Margin="0,8,12,0"/>

            <StackPanel Margin="32,48,32,24">

                <!-- Header -->
                <TextBlock Text="&#x1F433;" FontSize="36" Foreground="White" FontFamily="Segoe UI Emoji" HorizontalAlignment="Center" Margin="0,0,0,6"/>
                <TextBlock Text="PHP Docker Environment" FontSize="22" FontWeight="Bold" Foreground="White" FontFamily="Segoe UI" HorizontalAlignment="Center"/>
                <TextBlock Text="Apache 2.4    PHP 7.4    MariaDB 10.6    phpMyAdmin    Portainer" FontSize="10" Foreground="#8094a8" FontFamily="Segoe UI" HorizontalAlignment="Center" Margin="0,4,0,20"/>

                <!-- Action Buttons -->
                <Grid Margin="0,0,0,10">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="12"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>
                    <Button x:Name="BtnStart" Grid.Column="0" Content="&#x25B6;  Start" Style="{StaticResource ActionBtn}" Background="#059669"/>
                    <Button x:Name="BtnStop" Grid.Column="2" Content="&#x25A0;  Stop" Style="{StaticResource ActionBtn}" Background="#dc2626"/>
                </Grid>
                <Grid Margin="0,0,0,18">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="12"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>
                    <Button x:Name="BtnRestart" Grid.Column="0" Content="&#x21BA;  Restart" Style="{StaticResource ActionBtn}" Background="#0891b2"/>
                    <Button x:Name="BtnPortainer" Grid.Column="2" Content="&#x1F504;  Reset Portainer" Style="{StaticResource ActionBtn}" Background="#d97706"/>
                </Grid>

                <!-- Services -->
                <Border CornerRadius="10" Background="#0d1a30" Padding="16,12" Margin="0,0,0,16">
                    <Grid>
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="Auto"/>
                            <ColumnDefinition Width="14"/>
                            <ColumnDefinition Width="*"/>
                        </Grid.ColumnDefinitions>
                        <Grid.RowDefinitions>
                            <RowDefinition Height="26"/>
                            <RowDefinition Height="26"/>
                            <RowDefinition Height="26"/>
                            <RowDefinition Height="26"/>
                        </Grid.RowDefinitions>
                        <TextBlock Grid.Row="0" Grid.Column="0" Text="PHP Site" Foreground="#94a3b8" FontFamily="Segoe UI" FontSize="11.5"/>
                        <Button x:Name="LinkPHP" Grid.Row="0" Grid.Column="2" Content="http://localhost:8080" Style="{StaticResource LinkBtn}"/>
                        <TextBlock Grid.Row="1" Grid.Column="0" Text="phpMyAdmin" Foreground="#94a3b8" FontFamily="Segoe UI" FontSize="11.5"/>
                        <Button x:Name="LinkPMA" Grid.Row="1" Grid.Column="2" Content="http://localhost:8081" Style="{StaticResource LinkBtn}"/>
                        <TextBlock Grid.Row="2" Grid.Column="0" Text="Portainer" Foreground="#94a3b8" FontFamily="Segoe UI" FontSize="11.5"/>
                        <Button x:Name="LinkPort" Grid.Row="2" Grid.Column="2" Content="http://localhost:9000" Style="{StaticResource LinkBtn}"/>
                        <TextBlock Grid.Row="3" Grid.Column="0" Text="Dashboard" Foreground="#94a3b8" FontFamily="Segoe UI" FontSize="11.5"/>
                        <Button x:Name="LinkDash" Grid.Row="3" Grid.Column="2" Content="http://localhost:8082" Style="{StaticResource LinkBtn}"/>
                    </Grid>
                </Border>

                <!-- Status -->
                <TextBlock x:Name="StatusText" Text="Ready." FontSize="11" FontWeight="SemiBold" Foreground="#64748b" FontFamily="Segoe UI" Margin="0,0,0,6"/>

                <!-- Log -->
                <Border CornerRadius="10" Background="#0a0f1a" Padding="2" Height="150">
                    <TextBox x:Name="LogBox" IsReadOnly="True" TextWrapping="Wrap" VerticalScrollBarVisibility="Auto"
                             Background="Transparent" Foreground="#a5f3fc" FontFamily="Consolas" FontSize="10.5"
                             BorderThickness="0" Padding="10,8"/>
                </Border>

            </StackPanel>
        </Grid>
    </Border>
</Window>
"@

$reader = [System.Xml.XmlReader]::Create([System.IO.StringReader]::new($xaml))
$window = [System.Windows.Markup.XamlReader]::Load($reader)

# ── Get elements ──
$btnClose     = $window.FindName("BtnClose")
$btnStart     = $window.FindName("BtnStart")
$btnStop      = $window.FindName("BtnStop")
$btnRestart   = $window.FindName("BtnRestart")
$btnPortainer = $window.FindName("BtnPortainer")
$statusText   = $window.FindName("StatusText")
$logBox       = $window.FindName("LogBox")
$titleBar     = $window.FindName("TitleBar")
$linkPHP      = $window.FindName("LinkPHP")
$linkPMA      = $window.FindName("LinkPMA")
$linkPort     = $window.FindName("LinkPort")
$linkDash     = $window.FindName("LinkDash")

# ── Window drag ──
$titleBar.Add_MouseLeftButtonDown({ $window.DragMove() })

# ── Close ──
$btnClose.Add_Click({ $window.Close() })

# ── Link clicks ──
$linkPHP.Add_Click({ Start-Process "http://localhost:8080" })
$linkPMA.Add_Click({ Start-Process "http://localhost:8081" })
$linkPort.Add_Click({ Start-Process "http://localhost:9000" })
$linkDash.Add_Click({ Start-Process "http://localhost:8082" })

# ── Helper: run docker command ──
function Run-Docker($command, $status) {
    $statusText.Text = $status
    $statusText.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#0891b2")
    $logBox.Text = ""
    $window.Dispatcher.Invoke([Action]{}, [System.Windows.Threading.DispatcherPriority]::Render)

    $pinfo = New-Object System.Diagnostics.ProcessStartInfo
    $pinfo.FileName = "cmd.exe"
    $pinfo.Arguments = "/c $command 2>&1"
    $pinfo.RedirectStandardOutput = $true
    $pinfo.UseShellExecute = $false
    $pinfo.CreateNoWindow = $true
    $pinfo.WorkingDirectory = $projectPath

    $proc = [System.Diagnostics.Process]::Start($pinfo)
    $output = $proc.StandardOutput.ReadToEnd()
    $proc.WaitForExit()

    $logBox.Text = $output
    $logBox.ScrollToEnd()

    return $proc.ExitCode
}

$greenBrush  = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#059669")
$redBrush    = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#dc2626")
$orangeBrush = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#d97706")

# ── Button actions ──
$btnStart.Add_Click({
    $check = Run-Docker "docker info" "Checking Docker Desktop..."
    if ($check -ne 0) {
        $statusText.Text = "ERROR: Docker Desktop is not running!"
        $statusText.Foreground = $redBrush
        return
    }
    $r = Run-Docker "docker compose up -d" "Starting..."
    if ($r -eq 0) {
        $statusText.Text = "Environment started!"
        $statusText.Foreground = $greenBrush
        Start-Sleep -Seconds 2
        Start-Process "http://localhost:8082"
    } else {
        $statusText.Text = "ERROR: Failed to start."
        $statusText.Foreground = $redBrush
    }
})

$btnStop.Add_Click({
    $r = Run-Docker "docker compose down" "Stopping..."
    if ($r -eq 0) {
        $statusText.Text = "Environment stopped. Your data is preserved."
        $statusText.Foreground = $greenBrush
    } else {
        $statusText.Text = "ERROR: Failed to stop."
        $statusText.Foreground = $redBrush
    }
})

$btnRestart.Add_Click({
    $check = Run-Docker "docker info" "Checking Docker Desktop..."
    if ($check -ne 0) {
        $statusText.Text = "ERROR: Docker Desktop is not running!"
        $statusText.Foreground = $redBrush
        return
    }
    Run-Docker "docker compose down" "Stopping..."
    $r = Run-Docker "docker compose up -d" "Restarting..."
    if ($r -eq 0) {
        $statusText.Text = "Environment restarted successfully!"
        $statusText.Foreground = $greenBrush
    } else {
        $statusText.Text = "ERROR: Failed to restart."
        $statusText.Foreground = $redBrush
    }
})

$btnPortainer.Add_Click({
    Run-Docker "docker compose stop portainer" "Stopping Portainer..."
    Run-Docker "docker volume rm cours_portainer_data" "Removing data..."
    $r = Run-Docker "docker compose up -d portainer" "Restarting Portainer..."
    if ($r -eq 0) {
        $statusText.Text = "Portainer reset! Go to localhost:9000 NOW"
        $statusText.Foreground = $orangeBrush
        Start-Sleep -Seconds 2
        Start-Process "http://localhost:9000"
    } else {
        $statusText.Text = "ERROR: Failed to reset Portainer."
        $statusText.Foreground = $redBrush
    }
})

$window.ShowDialog() | Out-Null
