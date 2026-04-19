// ── Mobile Menu ──────────────────────────────────────────
const hamburger = document.getElementById('hamburger');
const mobileMenu = document.getElementById('mobile-menu');

hamburger.addEventListener('click', () => {
  mobileMenu.classList.toggle('open');
});

// Close mobile menu on link click
mobileMenu.querySelectorAll('a').forEach(link => {
  link.addEventListener('click', () => mobileMenu.classList.remove('open'));
});

// ── Scroll Animations ─────────────────────────────────────
const fadeEls = document.querySelectorAll(
  '.product-card, .why-point, .market-stat, .why-card, .hero-stat, .contact-detail-item'
);

fadeEls.forEach(el => el.classList.add('fade-in'));

const observer = new IntersectionObserver((entries) => {
  entries.forEach((entry, i) => {
    if (entry.isIntersecting) {
      setTimeout(() => entry.target.classList.add('visible'), i * 60);
      observer.unobserve(entry.target);
    }
  });
}, { threshold: 0.12 });

fadeEls.forEach(el => observer.observe(el));

// ── Navbar scroll shadow ──────────────────────────────────
const navbar = document.getElementById('navbar');
window.addEventListener('scroll', () => {
  navbar.style.boxShadow = window.scrollY > 10
    ? '0 1px 20px rgba(0,0,0,0.07)'
    : 'none';
});

// ── Contact Form ──────────────────────────────────────────
const form = document.getElementById('contact-form');
const note = document.getElementById('form-note');

form.addEventListener('submit', (e) => {
  e.preventDefault();
  const btn = form.querySelector('button[type="submit"]');
  const data = new FormData(form);
  
  btn.textContent = 'Sending...';
  btn.disabled = true;

  // Build mailto as reliable fallback
  const subject = encodeURIComponent('Kova Labs Demo Request — ' + (data.get('company') || data.get('name')));
  const body = encodeURIComponent(
    `Name: ${data.get('name')}\nCompany: ${data.get('company')}\nEmail: ${data.get('email')}\nPhone: ${data.get('phone') || 'N/A'}\nInterested in: ${data.get('interest') || 'N/A'}\n\nMessage:\n${data.get('message') || 'N/A'}`
  );
  
  // Open mail client
  window.location.href = `mailto:kovalabsug@gmail.com?subject=${subject}&body=${body}`;
  
  setTimeout(() => {
    note.textContent = '✓ Your mail client should open. Alternatively reach us at kovalabsug@gmail.com';
    note.style.color = '#6ee7b7';
    btn.textContent = 'Sent!';
    form.reset();
    setTimeout(() => { btn.textContent = 'Send Request ›'; btn.disabled = false; }, 3000);
  }, 800);
});

// ── Smooth active nav highlight ───────────────────────────
const sections = document.querySelectorAll('section[id]');
const navLinks = document.querySelectorAll('.nav-links a');

window.addEventListener('scroll', () => {
  let current = '';
  sections.forEach(sec => {
    if (window.scrollY >= sec.offsetTop - 120) current = sec.id;
  });
  navLinks.forEach(a => {
    a.style.color = a.getAttribute('href') === `#${current}`
      ? 'var(--ink)'
      : '';
  });
});