#!/bin/bash
# Install and start Nginx for RHEL/AL2
yum update -y
yum install -y nginx
systemctl start nginx
systemctl enable nginx

# Create the Rolls-Royce Showroom Template
cat <<EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>RR Luxury Showroom | Digistack Group</title>
    <style>
        :root {
            --rr-gold: #d4af37;
            --rr-silver: #e5e4e2;
            --rr-dark: #0a0a0a;
            --rr-card: #161616;
        }
        body { 
            font-family: 'Times New Roman', serif; 
            background-color: var(--rr-dark); 
            color: white; 
            margin: 0;
            padding: 20px;
        }
        .header {
            padding: 60px 20px;
            border-bottom: 1px solid #333;
            margin-bottom: 40px;
        }
        h1 { 
            font-size: 3.5em; 
            letter-spacing: 5px; 
            margin: 0;
            color: var(--rr-silver);
            text-transform: uppercase;
        }
        .subtitle { color: var(--rr-gold); font-style: italic; margin-top: 10px; }
        
        .collection-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .car-card {
            background: var(--rr-card);
            border: 1px solid #222;
            border-radius: 4px;
            padding: 40px 20px;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
        }
        
        .car-card:hover {
            border-color: var(--rr-gold);
            transform: translateY(-10px);
            background: #1c1c1c;
        }

        .car-card h2 {
            font-size: 1.8em;
            margin: 0 0 10px 0;
            color: var(--rr-silver);
        }

        .car-type {
            color: var(--rr-gold);
            font-size: 0.9em;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 15px;
        }

        .description {
            font-size: 0.95em;
            line-height: 1.6;
            color: #888;
        }

        .region-badge {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: rgba(212, 175, 55, 0.1);
            border: 1px solid var(--rr-gold);
            padding: 10px 20px;
            border-radius: 50px;
            font-size: 0.8em;
            color: var(--rr-gold);
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Rolls-Royce</h1>
        <div class="subtitle">The Pinnacle of Motor Cars</div>
    </div>

    <div class="collection-grid">
        <div class="car-card">
            <div class="car-type">Flagship Sedan</div>
            <h2>Phantom VIII</h2>
            <p class="description">The ultimate expression of bespoke luxury. A sanctuary of peace and power.</p>
        </div>

        <div class="car-card">
            <div class="car-type">All-Terrain SUV</div>
            <h2>Cullinan</h2>
            <p class="description">Effortless everywhere. The most capable ultra-luxury SUV ever created.</p>
        </div>

        <div class="car-card" style="border-color: #4a90e2;">
            <div class="car-type" style="color: #4a90e2;">Ultra-Luxury Electric</div>
            <h2>Spectre</h2>
            <p class="description">The first all-electric Rolls-Royce. The spiritual successor to the Phantom Coupé.</p>
        </div>

        <div class="car-card">
            <div class="car-type">Post-Opulent Sedan</div>
            <h2>Ghost Series II</h2>
            <p class="description">Designed with a minimalist philosophy, focusing on purity and substance.</p>
        </div>

        <div class="car-card" style="background: linear-gradient(145deg, #161616, #000);">
            <div class="car-type" style="color: #ff3e3e;">The Alter Ego</div>
            <h2>Black Badge</h2>
            <p class="description">For those who dare to be different. Increased power and darkened aesthetics.</p>
        </div>
    </div>

    <div class="region-badge">
        Server Live: <strong>ap-south-1a</strong>
    </div>
</body>
</html>
EOF
