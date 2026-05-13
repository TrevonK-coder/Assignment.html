/* =============================================
   main.js — Vibe & Watch Music Page
   Project 3: JavaScript Animation
   ============================================= */

// ── Canvas setup ─────────────────────────────
const canvas = document.getElementById('bgCanvas');
const ctx    = canvas.getContext('2d');

// Resize canvas to fill the viewport
function resizeCanvas() {
  canvas.width  = window.innerWidth;
  canvas.height = window.innerHeight;
}
resizeCanvas();
window.addEventListener('resize', resizeCanvas);

// ── Animation state ───────────────────────────
let isRunning  = true;
let speedMult  = 1;
let isFast     = false;

// Color palette options for the particles
const colorPalettes = [
  ['#a855f7', '#ec4899', '#6366f1'],   // Purple / Pink / Indigo (default)
  ['#06b6d4', '#3b82f6', '#8b5cf6'],   // Cyan / Blue / Violet
  ['#f59e0b', '#ef4444', '#f97316'],   // Amber / Red / Orange
  ['#10b981', '#34d399', '#06b6d4'],   // Emerald / Teal / Cyan
];
let paletteIndex = 0;

// ── Particle class ────────────────────────────
class Particle {
  constructor() {
    this.reset();
  }

  reset() {
    this.x     = Math.random() * canvas.width;
    this.y     = Math.random() * canvas.height;
    this.size  = Math.random() * 3 + 1;
    this.speedX = (Math.random() - 0.5) * 1.2;
    this.speedY = (Math.random() - 0.5) * 1.2;
    this.alpha  = Math.random() * 0.6 + 0.2;
    this.pulse  = Math.random() * Math.PI * 2; // phase offset for pulsing
    this.color  = colorPalettes[paletteIndex][
      Math.floor(Math.random() * colorPalettes[paletteIndex].length)
    ];
  }

  update() {
    const s = speedMult;
    this.x += this.speedX * s;
    this.y += this.speedY * s;
    this.pulse += 0.03 * s;

    // Slightly oscillate opacity to give a "breathing" look
    this.alpha = 0.3 + Math.sin(this.pulse) * 0.25;

    // Wrap around edges
    if (this.x < -10)             this.x = canvas.width  + 10;
    if (this.x > canvas.width  + 10) this.x = -10;
    if (this.y < -10)             this.y = canvas.height + 10;
    if (this.y > canvas.height + 10) this.y = -10;
  }

  draw() {
    ctx.save();
    ctx.globalAlpha = this.alpha;
    ctx.fillStyle   = this.color;
    ctx.shadowBlur  = 12;
    ctx.shadowColor = this.color;

    ctx.beginPath();
    ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
    ctx.fill();
    ctx.restore();
  }
}

// ── Create particles ──────────────────────────
const PARTICLE_COUNT = 120;
const particles = [];

for (let i = 0; i < PARTICLE_COUNT; i++) {
  particles.push(new Particle());
}

// ── Draw connecting lines between nearby particles ──
function drawConnections() {
  const maxDist = 110;
  for (let i = 0; i < particles.length; i++) {
    for (let j = i + 1; j < particles.length; j++) {
      const dx   = particles[i].x - particles[j].x;
      const dy   = particles[i].y - particles[j].y;
      const dist = Math.sqrt(dx * dx + dy * dy);

      if (dist < maxDist) {
        const opacity = (1 - dist / maxDist) * 0.18;
        ctx.save();
        ctx.strokeStyle = colorPalettes[paletteIndex][0];
        ctx.globalAlpha = opacity;
        ctx.lineWidth   = 0.8;
        ctx.beginPath();
        ctx.moveTo(particles[i].x, particles[i].y);
        ctx.lineTo(particles[j].x, particles[j].y);
        ctx.stroke();
        ctx.restore();
      }
    }
  }
}

// ── Main animation loop ───────────────────────
function animate() {
  if (!isRunning) return;

  // Clear with a semi-transparent dark fill to create a trail effect
  ctx.fillStyle = 'rgba(13, 13, 26, 0.25)';
  ctx.fillRect(0, 0, canvas.width, canvas.height);

  drawConnections();

  particles.forEach(p => {
    p.update();
    p.draw();
  });

  requestAnimationFrame(animate);
}

// Start the animation
animate();

// ── Control functions (called from HTML buttons) ──

/**
 * toggleAnimation — pause or resume the particle animation
 */
function toggleAnimation() {
  isRunning = !isRunning;
  const btn = document.getElementById('btnToggle');
  if (isRunning) {
    btn.textContent = '⏸ Pause';
    animate();  // restart the loop
  } else {
    btn.textContent = '▶ Resume';
  }
}

/**
 * cycleColor — switch to the next color palette
 */
function cycleColor() {
  paletteIndex = (paletteIndex + 1) % colorPalettes.length;
  // Re-assign colors to all existing particles
  particles.forEach(p => {
    p.color = colorPalettes[paletteIndex][
      Math.floor(Math.random() * colorPalettes[paletteIndex].length)
    ];
  });
}

/**
 * toggleSpeed — switch between normal and 3× speed
 */
function toggleSpeed() {
  isFast    = !isFast;
  speedMult = isFast ? 3 : 1;
  const btn = document.getElementById('btnSpeed');
  btn.textContent = isFast ? '🐢 Slow Down' : '⚡ Speed Up';
}

/**
 * burst — scatter all particles from the centre of the screen
 */
function burst() {
  const cx = canvas.width  / 2;
  const cy = canvas.height / 2;

  particles.forEach(p => {
    // Place each particle at the centre
    p.x = cx + (Math.random() - 0.5) * 40;
    p.y = cy + (Math.random() - 0.5) * 40;

    // Give them a strong random outward velocity
    const angle = Math.random() * Math.PI * 2;
    const speed = Math.random() * 6 + 3;
    p.speedX = Math.cos(angle) * speed;
    p.speedY = Math.sin(angle) * speed;
    p.size   = Math.random() * 5 + 2;   // temporarily bigger
  });

  // Return to gentle speeds after the burst fades
  setTimeout(() => {
    particles.forEach(p => {
      p.speedX = (Math.random() - 0.5) * 1.2;
      p.speedY = (Math.random() - 0.5) * 1.2;
      p.size   = Math.random() * 3 + 1;
    });
  }, 2000);
}
