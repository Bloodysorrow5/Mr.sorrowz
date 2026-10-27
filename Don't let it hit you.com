<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Google Workspace Docs</title> <!-- Tab camouflage -->
    <style>
        /* Smooth blue gradient styling */
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #9999FF 0%, #6666D4 50%, #4444AA 100%);
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
        }

        .panel {
            background: rgba(25, 25, 50, 0.45);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3);
            text-align: center;
            max-width: 450px;
            width: 90%;
        }

        h1 {
            font-size: 2.2rem;
            margin-bottom: 5px;
            letter-spacing: -0.5px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }

        .subtitle {
            font-size: 0.95rem;
            color: #E0E0FF;
            margin-bottom: 30px;
        }

        .input-group {
            margin-bottom: 20px;
            position: relative;
        }

        input {
            width: 100%;
            padding: 14px 20px;
            font-size: 1rem;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            color: white;
            box-sizing: border-box;
            outline: none;
            transition: all 0.3s ease;
        }

        input:focus {
            background: rgba(255, 255, 255, 0.15);
            border-color: #9999FF;
            box-shadow: 0 0 10px rgba(153, 153, 255, 0.3);
        }

        input::placeholder {
            color: #CCC;
        }

        .btn {
            width: 100%;
            padding: 14px;
            font-size: 1rem;
            font-weight: 600;
            color: #222;
            background: #FFFFFF;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: transform 0.2s, background-color 0.2s;
            box-shadow: 0 4px 15px rgba(0,0,0,0.15);
        }

        .btn:hover {
            background: #E5E5FF;
            transform: translateY(-1px);
        }

        .btn:active {
            transform: translateY(1px);
        }

        .hint {
            font-size: 0.8rem;
            color: #D1D1F6;
            margin-top: 15px;
            line-height: 1.4;
        }
    </style>
</head>
<body>

    <div class="panel">
        <h1>Web Terminal</h1>
        <div class="subtitle">Deploy unblocked environment into standard blank frame</div>
        
        <div class="input-group">
            <input type="text" id="targetUrl" placeholder="Enter game or proxy link (e.g., poki.com)">
        </div>
        
        <button class="btn" onclick="launchBlank()">Launch Cloaked Environment</button>
        
        <div class="hint">
            Launches web traffic securely via a standalone <strong>about:blank</strong> sandbox frame, masking history logs from active dashboard tracking tools.
        </div>
    </div>

    <script>
        function launchBlank() {
            let inputField = document.getElementById('targetUrl');
            let target = inputField.value.trim();

            if (!target) {
                alert('Please input a target destination URL.');
                return;
            }

            // Enforce proper protocol header formatting
            if (!target.startsWith('http://') && !target.startsWith('https://')) {
                target = 'https://' + target;
            }

            // Create blank standalone frame environment
            const docWin = window.open('about:blank', '_blank');
            if (!docWin) {
                alert('Pop-up blocked! Please click allow pop-ups in the top right to launch.');
                return;
            }

            const bodyStyle = docWin.document.body.style;
            bodyStyle.margin = '0';
            bodyStyle.height = '100vh';
            bodyStyle.backgroundColor = '#000';

            // Build full viewport sandbox
            const sandBoxFrame = docWin.document.createElement('iframe');
            const frameStyle = sandBoxFrame.style;
            
            frameStyle.border = 'none';
            frameStyle.width = '100%';
            frameStyle.height = '100%';
            frameStyle.margin = '0';
            frameStyle.padding = '0';
            frameStyle.overflow = 'hidden';
            
            // Assign target location
            sandBoxFrame.src = target;

            docWin.document.body.appendChild(sandBoxFrame);
        }

        // Allow executing via pressing Enter key
        document.getElementById('targetUrl').addEventListener('keydown', function(e) {
            if (e.key === 'Enter') {
                launchBlank();
            }
        });
    </script>
</body>
</html>
