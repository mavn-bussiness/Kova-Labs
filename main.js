    // ── Mobile Menu ──
    const hamburger = document.getElementById('hamburger');
    const mobileMenu = document.getElementById('mobile-menu');
    if (hamburger && mobileMenu) {
      hamburger.addEventListener('click', () => mobileMenu.classList.toggle('open'));
      mobileMenu.querySelectorAll('a').forEach(l => l.addEventListener('click', () => mobileMenu.classList.remove('open')));
    }

    // ── Dashboard Bars ──
    const dashBars = document.getElementById('dashBars');
    let barData = [42, 68, 54, 87, 72, 94, 68, 55, 82, 73];
    function renderDashBars() {
      if (!dashBars) return;
      dashBars.innerHTML = '';
      barData.forEach(v => {
        const b = document.createElement('div');
        b.className = 'dm-bar';
        b.style.height = Math.max(14, (v/100)*56) + 'px';
        dashBars.appendChild(b);
      });
    }
    renderDashBars();
    setInterval(() => {
      barData = barData.map(() => 30 + Math.floor(Math.random() * 70));
      renderDashBars();
    }, 3500);

    // ── Live Fleet Counter ──
    let vc = 24;
    const vcEl = document.getElementById('liveVehicleCount');
    const alEl = document.getElementById('alertCount');
    setInterval(() => {
      vc = Math.max(18, Math.min(32, vc + Math.floor(Math.random() * 3) - 1));
      if (vcEl) vcEl.textContent = vc;
      if (alEl) alEl.textContent = Math.floor(Math.random() * 5);
    }, 5000);

    // ── Compliance Score ──
    const cf = document.getElementById('complianceFill');
    const cb = document.getElementById('complianceBadge');
    setInterval(() => {
      const w = 87 + Math.floor(Math.random() * 10);
      if (cf) cf.style.width = w + '%';
      if (cb) cb.textContent = w + '%';
    }, 8000);

    // ── Dashboard txn counter ──
    const txnEl = document.getElementById('txnCount');
    let txn = 1482;
    setInterval(() => {
      txn += Math.floor(Math.random() * 8);
      if (txnEl) txnEl.textContent = txn.toLocaleString();
    }, 4000);

    // ── Scroll Animations ──
    document.querySelectorAll('.fade-in-up').forEach(el => {
      new IntersectionObserver((entries) => {
        entries.forEach((e, i) => {
          if (e.isIntersecting) {
            setTimeout(() => e.target.classList.add('visible'), i * 70);
            e.target._obs?.unobserve(e.target);
          }
        });
      }, { threshold: 0.08 }).observe(el);
    });

    // ── Navbar shadow on scroll ──
    const navbar = document.getElementById('navbar');
    window.addEventListener('scroll', () => {
      if (navbar) navbar.style.boxShadow = window.scrollY > 10 ? '0 2px 24px rgba(0,0,0,0.07)' : 'none';
    }, { passive: true });

    // ── Active nav highlight ──
    const sections = document.querySelectorAll('section[id]');
    const navLinks = document.querySelectorAll('.nav-links a');
    window.addEventListener('scroll', () => {
      let cur = '';
      sections.forEach(s => { if (window.scrollY >= s.offsetTop - 130) cur = s.id; });
      navLinks.forEach(l => {
        l.style.color = l.getAttribute('href') === `#${cur}` ? 'var(--accent)' : '';
      });
    }, { passive: true });

    // ── Contact Form ──
    const form = document.getElementById('contact-form');
    const formNote = document.getElementById('form-note');
    if (form) {
      form.addEventListener('submit', e => {
        e.preventDefault();
        const btn = form.querySelector('button[type="submit"]');
        const orig = btn.textContent;
        btn.textContent = 'Sending...'; btn.disabled = true;
        const fd = new FormData(form);
        const subject = encodeURIComponent(`Kova Labs Enquiry — ${fd.get('company') || fd.get('name')}`);
        const body = encodeURIComponent(
          `Name: ${fd.get('name')}\nCompany: ${fd.get('company')}\nEmail: ${fd.get('email')}\nPhone: ${fd.get('phone')||'N/A'}\nInterest: ${fd.get('interest')}\n\nMessage:\n${fd.get('message')}`
        );
        window.location.href = `mailto:kovalabsug@gmail.com?subject=${subject}&body=${body}`;
        setTimeout(() => {
          if (formNote) { formNote.textContent = '✓ Request sent! We\'ll be in touch within 24 hours.'; formNote.className = 'form-note success'; }
          btn.textContent = 'Sent ✓'; form.reset();
          setTimeout(() => { btn.textContent = orig; btn.disabled = false; if (formNote) { formNote.textContent=''; formNote.className='form-note'; } }, 4000);
        }, 600);
      });
    }

    // ── Smooth scroll ──
    document.querySelectorAll('a[href^="#"]').forEach(a => {
      a.addEventListener('click', function(e) {
        const t = document.querySelector(this.getAttribute('href'));
        if (t && this.getAttribute('href') !== '#') { e.preventDefault(); t.scrollIntoView({ behavior: 'smooth', block: 'start' }); }
      });
    });