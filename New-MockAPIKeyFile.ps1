function New-MockAPIKeyFile {
    <#
    .SYNOPSIS
        Creates mock API key configuration files for testing and development purposes.

    .DESCRIPTION
        The New-MockAPIKeyFile cmdlet generates realistic-looking API key configuration files 
        for various services including OpenAI, Stripe, AWS, Azure, and many others. These files 
        contain placeholder/mock credentials that can be used for testing, development, or 
        demonstration purposes.

        The cmdlet creates JSON files with service-specific structures and realistic-looking 
        (but non-functional) API keys, tokens, and other credential fields.

    .PARAMETER Path
        Specifies the directory path where the API key file will be created. 
        Defaults to the current user's Documents folder.

    .PARAMETER Username
        Specifies the username to use in credential files where applicable.
        Defaults to the current user's username.

    .PARAMETER Service
        Specifies which service to create an API key file for. If not specified, 
        a random service will be selected.
        
        Valid values: OpenAI, Stripe, PayPal, AWS, Azure, GCP, Square, Claude, 
        Verkada, YouTube, Twilio, SendGrid, Shopify, Discord, Slack, GitHub, 
        GitLab, Dropbox, Mailchimp, Zoom

    .PARAMETER All
        Creates API key files for all available services in the specified path.
        Cannot be used with the -Service parameter.

    .PARAMETER PassThru
        Returns an object containing details about the created file(s).

    .OUTPUTS
        PSCustomObject (when -PassThru is used)
        Returns an object with Service, Filename, and FilePath properties.

    .EXAMPLE
        New-MockAPIKeyFile
        
        Creates a random API key file in the Documents folder.

    .EXAMPLE
        New-MockAPIKeyFile -Path "C:\Dev\Config" -Service "OpenAI"
        
        Creates an OpenAI API key file in the specified directory.

    .EXAMPLE
        New-MockAPIKeyFile -Service "AWS" -Username "testuser" -PassThru
        
        Creates an AWS credentials file with the specified username and returns file details.

    .EXAMPLE
        New-MockAPIKeyFile -All -Path "C:\Dev\MockCredentials"
        
        Creates API key files for all supported services in the specified directory.

    .EXAMPLE
        New-MockAPIKeyFile -All -PassThru | Format-Table
        
        Creates files for all services and displays the results in a table format.

    .NOTES
        Author: Jim Tyler
        Website: https://guerillazerotrust.com | https://www.powershellengineer.com
        Version: 1.0
        
        WARNING: The API keys and credentials generated by this cmdlet are for testing 
        purposes only and should never be used in production environments. These are 
        mock/placeholder values that will not authenticate with actual services.

    .LINK
        https://docs.microsoft.com/en-us/powershell/
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateScript({Test-Path $_ -PathType Container})]
        [string]$Path = [Environment]::GetFolderPath('MyDocuments'),
        
        [Parameter(Mandatory = $false)]
        [string]$Username = $env:USERNAME,
        
        [Parameter(Mandatory = $false)]
        [ValidateSet("OpenAI", "Stripe", "PayPal", "AWS", "Azure", "GCP", "Square", "Claude", 
                     "Verkada", "YouTube", "Twilio", "SendGrid", "Shopify", "Discord", 
                     "Slack", "GitHub", "GitLab", "Dropbox", "Mailchimp", "Zoom")]
        [string]$Service,
        
        [Parameter(Mandatory = $false)]
        [switch]$All,
        
        [Parameter(Mandatory = $false)]
        [switch]$PassThru
    )

    # Helper function to generate random API keys
    function Generate-RandomAPIKey {
        param([string]$ServiceType)
        
        switch ($ServiceType) {
            "openai" { return "sk-" + (-join ((1..48) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) })) }
            "stripe" { return "sk_live_" + (-join ((1..24) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) })) }
            "paypal" { return "A" + (-join ((1..80) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) })) }
            "aws" { return "AKIA" + (-join ((1..16) | ForEach-Object { [char]((65..90) + (48..57) | Get-Random) })) }
            "azure" { return (-join ((1..32) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95, 126, 46) | Get-Random) })) }
            "gcp" { return (-join ((1..40) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) })) }
            default { return (-join ((1..32) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) })) }
        }
    }

    # Define API services configuration
    $APIServices = @(
        @{ 
            Service = "OpenAI"; Type = "openai"; 
            Patterns = @("openai_api_key.json", "chatgpt_key.json", "openai_secret.json", "ai_api_credentials.json")
            JSONTemplate = @{
                "api_key" = ""
                "organization" = "org-" + (-join ((1..24) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
            }
        },
        @{ 
            Service = "Stripe"; Type = "stripe"; 
            Patterns = @("stripe_api_key.json", "stripe_secret.json", "payment_keys.json", "stripe_credentials.json")
            JSONTemplate = @{
                "secret_key" = ""
                "publishable_key" = "pk_live_" + (-join ((1..24) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                "webhook_secret" = "whsec_" + (-join ((1..32) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
            }
        },
        @{ 
            Service = "PayPal"; Type = "paypal"; 
            Patterns = @("paypal_api_key.json", "paypal_credentials.json", "paypal_secret.json", "payment_api.json")
            JSONTemplate = @{
                "client_id" = ""
                "client_secret" = (-join ((1..64) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                "mode" = "live"
            }
        },
        @{ 
            Service = "AWS"; Type = "aws"; 
            Patterns = @("aws_api_key.json", "amazon_credentials.json", "aws_secret.json", "cloud_keys.json")
            JSONTemplate = @{
                "AccessKeyId" = ""
                "SecretAccessKey" = (-join ((1..40) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(43, 47) | Get-Random) }))
                "Region" = @("us-east-1", "us-west-2", "eu-west-1", "ap-southeast-1") | Get-Random
            }
        },
        @{ 
            Service = "Azure"; Type = "azure"; 
            Patterns = @("azure_api_key.json", "microsoft_credentials.json", "azure_secret.json", "azure_keys.json")
            JSONTemplate = @{
                "subscription_id" = [guid]::NewGuid().ToString()
                "client_id" = [guid]::NewGuid().ToString()
                "client_secret" = ""
                "tenant_id" = [guid]::NewGuid().ToString()
            }
        },
        @{ 
            Service = "GCP"; Type = "gcp"; 
            Patterns = @("gcp_api_key.json", "google_cloud_key.json", "gcp_credentials.json", "google_api.json")
            JSONTemplate = @{
                "type" = "service_account"
                "project_id" = "my-project-" + (-join ((1..6) | ForEach-Object { [char](48..57 | Get-Random) }))
                "private_key_id" = (-join ((1..40) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) }))
                "private_key" = "-----BEGIN PRIVATE KEY-----`nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC..." + (-join ((1..50) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) })) + "`n-----END PRIVATE KEY-----"
                "client_email" = "service-account@my-project-" + (-join ((1..6) | ForEach-Object { [char](48..57 | Get-Random) })) + ".iam.gserviceaccount.com"
                "client_id" = (-join ((1..21) | ForEach-Object { [char](48..57 | Get-Random) }))
            }
        },
        @{ 
            Service = "Square"; Type = "generic"; 
            Patterns = @("square_api_key.json", "square_credentials.json", "square_secret.json", "pos_api.json")
            JSONTemplate = @{
                "application_id" = "sq0idp-" + (-join ((1..43) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) }))
                "access_token" = ""
                "environment" = "production"
                "location_id" = (-join ((1..22) | ForEach-Object { [char]((65..90) + (48..57) | Get-Random) }))
            }
        },
        @{ 
            Service = "Claude"; Type = "generic"; 
            Patterns = @("claude_api_key.json", "anthropic_key.json", "claude_credentials.json", "anthropic_api.json")
            JSONTemplate = @{
                "api_key" = ""
                "model" = "claude-3-sonnet-20240229"
                "max_tokens" = 4096
            }
        },
        @{ 
            Service = "Verkada"; Type = "generic"; 
            Patterns = @("verkada_api_key.json", "verkada_credentials.json", "camera_api.json", "verkada_secret.json")
            JSONTemplate = @{
                "api_key" = ""
                "org_id" = (-join ((1..8) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) })) + "-" + (-join ((1..4) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) })) + "-" + (-join ((1..4) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) })) + "-" + (-join ((1..4) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) })) + "-" + (-join ((1..12) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) }))
                "base_url" = "https://api.verkada.com"
            }
        },
        @{ 
            Service = "YouTube"; Type = "generic"; 
            Patterns = @("youtube_api_key.json", "google_youtube_key.json", "youtube_credentials.json", "video_api.json")
            JSONTemplate = @{
                "api_key" = ""
                "quota_user" = $Username
                "part" = @("snippet", "statistics", "contentDetails")
            }
        },
        @{ 
            Service = "Twilio"; Type = "generic"; 
            Patterns = @("twilio_api_key.json", "sms_api_key.json", "twilio_credentials.json", "messaging_api.json")
            JSONTemplate = @{
                "account_sid" = "AC" + (-join ((1..32) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) }))
                "auth_token" = ""
                "api_key" = "SK" + (-join ((1..32) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) }))
                "api_secret" = (-join ((1..32) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
            }
        },
        @{ 
            Service = "SendGrid"; Type = "generic"; 
            Patterns = @("sendgrid_api_key.json", "email_api_key.json", "sendgrid_secret.json", "mail_credentials.json")
            JSONTemplate = @{
                "api_key" = "SG." + (-join ((1..22) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) })) + "." + (-join ((1..43) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) }))
                "from_email" = "noreply@" + (-join ((1..8) | ForEach-Object { [char]((97..122) | Get-Random) })) + ".com"
            }
        },
        @{ 
            Service = "Shopify"; Type = "generic"; 
            Patterns = @("shopify_api_key.json", "store_credentials.json", "ecommerce_api.json", "shopify_secret.json")
            JSONTemplate = @{
                "api_key" = (-join ((1..32) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) }))
                "password" = ""
                "shared_secret" = (-join ((1..32) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) }))
                "shop_domain" = (-join ((1..8) | ForEach-Object { [char]((97..122) | Get-Random) })) + ".myshopify.com"
            }
        },
        @{ 
            Service = "Discord"; Type = "generic"; 
            Patterns = @("discord_bot_token.json", "discord_api_key.json", "bot_credentials.json", "discord_secret.json")
            JSONTemplate = @{
                "bot_token" = ""
                "client_id" = (-join ((1..18) | ForEach-Object { [char](48..57 | Get-Random) }))
                "client_secret" = (-join ((1..32) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) }))
                "guild_id" = (-join ((1..18) | ForEach-Object { [char](48..57 | Get-Random) }))
            }
        },
        @{ 
            Service = "Slack"; Type = "generic"; 
            Patterns = @("slack_api_key.json", "slack_bot_token.json", "workspace_credentials.json", "slack_webhook.json")
            JSONTemplate = @{
                "bot_token" = "xoxb-" + (-join ((1..11) | ForEach-Object { [char](48..57 | Get-Random) })) + "-" + (-join ((1..11) | ForEach-Object { [char](48..57 | Get-Random) })) + "-" + (-join ((1..24) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                "app_token" = "xapp-1-" + (-join ((1..11) | ForEach-Object { [char]((65..90) + (48..57) | Get-Random) })) + "-" + (-join ((1..11) | ForEach-Object { [char](48..57 | Get-Random) })) + "-" + (-join ((1..64) | ForEach-Object { [char]((97..122) + (48..57) | Get-Random) }))
                "webhook_url" = "https://hooks.slack.com/services/T" + (-join ((1..8) | ForEach-Object { [char]((65..90) + (48..57) | Get-Random) })) + "/B" + (-join ((1..8) | ForEach-Object { [char]((65..90) + (48..57) | Get-Random) })) + "/" + (-join ((1..24) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
            }
        },
        @{ 
            Service = "GitHub"; Type = "generic"; 
            Patterns = @("github_token.json", "git_credentials.json", "repo_access_token.json", "github_api_key.json")
            JSONTemplate = @{
                "token" = "ghp_" + (-join ((1..36) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
                "username" = $Username
                "scope" = @("repo", "user", "admin:org")
            }
        },
        @{ 
            Service = "GitLab"; Type = "generic"; 
            Patterns = @("gitlab_token.json", "gitlab_api_key.json", "git_access_token.json", "gitlab_credentials.json")
            JSONTemplate = @{
                "access_token" = "glpat-" + (-join ((1..20) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) }))
                "username" = $Username
                "gitlab_url" = "https://gitlab.com"
            }
        },
        @{ 
            Service = "Dropbox"; Type = "generic"; 
            Patterns = @("dropbox_api_key.json", "storage_credentials.json", "dropbox_token.json", "file_api_key.json")
            JSONTemplate = @{
                "access_token" = "sl." + (-join ((1..43) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) }))
                "app_key" = (-join ((1..15) | ForEach-Object { [char]((97..122) + (48..57) | Get-Random) }))
                "app_secret" = (-join ((1..15) | ForEach-Object { [char]((97..122) + (48..57) | Get-Random) }))
            }
        },
        @{ 
            Service = "Mailchimp"; Type = "generic"; 
            Patterns = @("mailchimp_api_key.json", "email_marketing_key.json", "mailchimp_secret.json", "campaign_api.json")
            JSONTemplate = @{
                "api_key" = (-join ((1..32) | ForEach-Object { [char]((48..57) + (97..102) | Get-Random) })) + "-us1"
                "server" = "us1"
                "username" = $Username
            }
        },
        @{ 
            Service = "Zoom"; Type = "generic"; 
            Patterns = @("zoom_api_key.json", "video_conf_key.json", "zoom_credentials.json", "meeting_api.json")
            JSONTemplate = @{
                "api_key" = (-join ((1..22) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) + @(45, 95) | Get-Random) }))
                "api_secret" = ""
                "jwt_token" = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9." + (-join ((1..100) | ForEach-Object { [char]((65..90) + (97..122) + (48..57) | Get-Random) }))
            }
        }
    )

    # Validate parameter combinations
    if ($Service -and $All) {
        Write-Error "Cannot specify both -Service and -All parameters. Use one or the other."
        return
    }

    # Select service(s) to process
    if ($All) {
        $ServicesToProcess = $APIServices
        Write-Host "Creating mock API key files for all $($APIServices.Count) services..." -ForegroundColor Yellow
    } elseif ($Service) {
        $SelectedService = $APIServices | Where-Object { $_.Service -eq $Service }
        if (-not $SelectedService) {
            Write-Error "Invalid service specified: $Service"
            return
        }
        $ServicesToProcess = @($SelectedService)
    } else {
        $ServicesToProcess = @((Get-Random -InputObject $APIServices))
    }

    $Results = @()

    foreach ($CurrentService in $ServicesToProcess) {
        # Select random filename pattern for this service
        $SelectedFilename = Get-Random -InputObject $CurrentService.Patterns
        
        # Generate API key based on service type
        $APIKey = Generate-RandomAPIKey -ServiceType $CurrentService.Type
        
        # Create JSON content based on service template
        $JSONData = $CurrentService.JSONTemplate.Clone()
        
        # Set the main API key field based on service
        switch ($CurrentService.Service) {
            "OpenAI" { $JSONData["api_key"] = $APIKey }
            "Stripe" { $JSONData["secret_key"] = $APIKey }
            "PayPal" { $JSONData["client_id"] = $APIKey }
            "AWS" { $JSONData["AccessKeyId"] = $APIKey }
            "Azure" { $JSONData["client_secret"] = $APIKey }
            "Square" { $JSONData["access_token"] = $APIKey }
            "Claude" { $JSONData["api_key"] = $APIKey }
            "Verkada" { $JSONData["api_key"] = $APIKey }
            "YouTube" { $JSONData["api_key"] = $APIKey }
            "Twilio" { $JSONData["auth_token"] = $APIKey }
            "Shopify" { $JSONData["password"] = $APIKey }
            "Discord" { $JSONData["bot_token"] = $APIKey }
            "Zoom" { $JSONData["api_secret"] = $APIKey }
            default { $JSONData["api_key"] = $APIKey }
        }
        
        # Convert to JSON with proper formatting
        $JSONContent = $JSONData | ConvertTo-Json -Depth 4
        
        # Save JSON file
        $FilePath = Join-Path -Path $Path -ChildPath $SelectedFilename
        
        try {
            Set-Content -Path $FilePath -Value $JSONContent -Encoding UTF8 -ErrorAction Stop
            
            if ($All) {
                Write-Host "  ✓ $($CurrentService.Service): $SelectedFilename" -ForegroundColor Green
            } else {
                Write-Host "Created mock API key file: $SelectedFilename" -ForegroundColor Green
                Write-Host "Service: $($CurrentService.Service)" -ForegroundColor Cyan
                Write-Host "Path: $FilePath" -ForegroundColor Gray
            }
            
            # Collect results for PassThru
            $Results += [PSCustomObject]@{
                Service = $CurrentService.Service
                Filename = $SelectedFilename
                FilePath = $FilePath
                PSTypeName = 'MockAPIKeyFile'
            }
        }
        catch {
            Write-Error "Failed to create file for $($CurrentService.Service): $($_.Exception.Message)"
        }
    }

    if ($All) {
        Write-Host "Completed creating $($Results.Count) mock API key files in: $Path" -ForegroundColor Yellow
    }

    # Return details if PassThru is specified
    if ($PassThru) {
        if ($Results.Count -eq 1) {
            return $Results[0]
        } else {
            return $Results
        }
    }
}

# Export the function if this script is dot-sourced
#Export-ModuleMember -Function New-MockAPIKeyFile

New-MockAPIKeyFile -All -Path "C:\Users\Jim\Downloads\Users\"
