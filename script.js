// Data handling for Mbrojtja.ks
const STORAGE_KEY = 'mbrojtja_reports_v1';
const THEME_KEY = 'mbrojtja_theme_v1';
const LOCATION_PICK_KEY = 'mbrojtja_pending_location_v1';
const WELCOME_OVERLAY_SESSION_KEY = 'mbrojtja_welcome_continue_ok_v1';
const GJILAN_STREETS_CACHE_KEY = 'mbrojtja_gjilan_street_names_v1';
const GJILAN_STREETS_CACHE_MAX_AGE_MS = 7 * 24 * 60 * 60 * 1000;
const CHAT_STORAGE_KEY = 'mbrojtja_community_chat_v1';
const CHAT_NICK_KEY = 'mbrojtja_chat_nick_v1';
const CHAT_NICK_LOCK_UNTIL_KEY = 'mbrojtja_chat_nick_lock_until_v1';
const CHAT_OWNER_KEY = 'mbrojtja_chat_owner_v1';
const CHAT_NICK_LOCK_MS = 10 * 24 * 60 * 60 * 1000;
const CHAT_ATTACH_MAX_BYTES = Math.floor(2.5 * 1024 * 1024);
const CHAT_ATTACH_MAX_FILES = 5;
const GJILAN_VILLAGES = [
    'Bilinicë', 'Bresalc', 'Bukovik', 'Burincë', 'Capar', 'Cërnicë', 'Demiraj',
    'Dobërçan', 'Dunav', 'Gadish', 'Gadish i Epërm', 'Gadish i Poshtëm', 'Haxhaj',
    'Kishnapolë', 'Livoç i Epërm', 'Livoç i Poshtëm', 'Llashticë', 'Malishevë',
    'Muçivërc', 'Nazdrakovc', 'Përlepnicë', 'Pidiq', 'Pogragjë', 'Shillovë',
    'Sllakoc i Epërm', 'Sllakoc i Poshtëm', 'Sllubicë', 'Stançiq', 'Strazhë',
    'Uglar', 'Velekincë', 'Verbicë e Zhegocit', 'Zhegër'
];

// Global state
let currentReports = JSON.parse(localStorage.getItem(STORAGE_KEY)) || [];
let activeItem = null;
let detailModal = null;
let chatNickCountdownIntervalId = null;

// Initial Load
document.addEventListener('DOMContentLoaded', () => {
    detailModal = document.getElementById('detailModal');
    updateList();
    initTheme();
    initSmoothScroll();
    initVillageLagjjaSelector();
    initLocationPicker();
    initMapPickerPage();
    initRiskMapHome();
    initCommunityChat();
    initWelcomeOverlay();

    // Modal Close
    const closeModal = document.querySelector('.close-modal');
    if (closeModal) {
        closeModal.onclick = () => detailModal?.classList.remove('active');
    }
    
    window.onclick = (event) => {
        if (detailModal && event.target == detailModal) {
            detailModal.classList.remove('active');
        }
    };

    // Re-attach form handler if exists
    const reportForm = document.getElementById('reportForm');
    if (reportForm) {
        reportForm.onsubmit = handleFormSubmit;
    }
});

function initWelcomeOverlay() {
    const overlay = document.getElementById('welcomeOverlay');
    const btn = document.getElementById('welcomeOverlayContinue');
    if (!overlay || !btn) return;

    if (sessionStorage.getItem(WELCOME_OVERLAY_SESSION_KEY) === '1') {
        overlay.classList.add('is-dismissed');
        return;
    }

    const show = () => {
        overlay.setAttribute('aria-hidden', 'false');
        document.body.classList.add('welcome-no-scroll');
        requestAnimationFrame(() => {
            overlay.classList.add('is-visible');
            btn.focus();
        });
    };

    const hide = () => {
        overlay.classList.remove('is-visible');
        document.body.classList.remove('welcome-no-scroll');
        overlay.setAttribute('aria-hidden', 'true');
        const finish = () => {
            if (overlay.classList.contains('is-dismissed')) return;
            overlay.classList.add('is-dismissed');
        };
        const onEnd = (e) => {
            if (e.target !== overlay || e.propertyName !== 'opacity') return;
            overlay.removeEventListener('transitionend', onEnd);
            finish();
        };
        overlay.addEventListener('transitionend', onEnd);
        window.setTimeout(() => {
            overlay.removeEventListener('transitionend', onEnd);
            if (!overlay.classList.contains('is-dismissed')) finish();
        }, 600);
    };

    btn.addEventListener('click', () => {
        sessionStorage.setItem(WELCOME_OVERLAY_SESSION_KEY, '1');
        hide();
    });

    show();
}

function initSmoothScroll() {
    document.querySelectorAll('a[href^="#"]').forEach((a) => {
        a.addEventListener('click', (e) => {
            const href = a.getAttribute('href');
            if (!href || href === '#') return;
            const id = href.slice(1);
            const target = document.getElementById(id);
            if (!target) return;

            e.preventDefault();

            const header = document.querySelector('header');
            const headerOffset = header ? header.getBoundingClientRect().height + 12 : 12;
            const targetTop = target.getBoundingClientRect().top + window.scrollY - headerOffset;

            window.scrollTo({ top: targetTop, behavior: 'smooth' });
        });
    });
}

// Theme Logic
function initTheme() {
    const savedTheme = localStorage.getItem(THEME_KEY) || 'light';
    document.documentElement.setAttribute('data-theme', savedTheme);
    updateThemeIcon(savedTheme);

    const themeBtn = document.getElementById('themeToggle');
    if (themeBtn) {
        themeBtn.onclick = () => {
            const current = document.documentElement.getAttribute('data-theme');
            const target = current === 'light' ? 'dark' : 'light';
            document.documentElement.setAttribute('data-theme', target);
            localStorage.setItem(THEME_KEY, target);
            updateThemeIcon(target);
        };
    }
}

function updateThemeIcon(theme) {
    const icon = document.getElementById('themeIcon');
    if (!icon) return;
    if (theme === 'dark') {
        icon.innerHTML = '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="5"/><path d="M12 1v2M12 21v2M4.22 4.22l1.42 1.42M18.36 18.36l1.42 1.42M1 12h2M21 12h2M4.22 19.78l1.42-1.42M18.36 5.64l1.42-1.42"/></svg>';
    } else {
        icon.innerHTML = '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"/></svg>';
    }
}

// Form Submission
function handleFormSubmit(e) {
    e.preventDefault();
    const pageType = document.body.dataset.page; 
    const municipality = document.getElementById('municipality').value;
    const village = document.getElementById('village').value;
    const eventDate = document.getElementById('eventDate').value;
    const exactLocationInput = document.getElementById('exactLocation');
    const exactLocation = exactLocationInput ? exactLocationInput.value : '';
    const locationLatInput = document.getElementById('locationLat');
    const locationLngInput = document.getElementById('locationLng');
    const locationStreetInput = document.getElementById('locationStreet');
    const locationLat = locationLatInput && locationLatInput.value ? parseFloat(locationLatInput.value) : null;
    const locationLng = locationLngInput && locationLngInput.value ? parseFloat(locationLngInput.value) : null;
    const streetName = locationStreetInput ? locationStreetInput.value : '';
    const content = document.getElementById('content').value;

    if (pageType === 'request' && !exactLocation) {
        alert('Ju lutem zgjidhni vendndodhjen me butonin «Zgjidhni Vendndodhjen…».');
        return;
    }

    const newReport = {
        id: Date.now().toString(),
        type: pageType,
        municipality,
        village: village || 'Nuk ka',
        eventDate,
        exactLocation,
        streetName,
        locationLat,
        locationLng,
        content,
        date: new Date().toLocaleDateString('sq-AL'),
        time: new Date().toLocaleTimeString('sq-AL', { hour: '2-digit', minute: '2-digit' })
    };

    currentReports.unshift(newReport);
    saveReports();
    updateList();
    e.target.reset();
    clearPickedLocationPreview();
    
    alert('Raporti u ruajt me sukses!');
}

function saveReports() {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(currentReports));
}

function escapeChatHtml(text) {
    const div = document.createElement('div');
    div.textContent = text == null ? '' : String(text);
    return div.innerHTML;
}

function getChatNickLockUntilMs() {
    const raw = localStorage.getItem(CHAT_NICK_LOCK_UNTIL_KEY);
    if (!raw) return 0;
    const n = parseInt(raw, 10);
    return Number.isFinite(n) ? n : 0;
}

function isChatNickLocked() {
    return getChatNickLockUntilMs() > Date.now();
}

function applyChatNickLockUI(nickInput, saveBtn, hintEl) {
    if (!nickInput) return;
    const until = getChatNickLockUntilMs();
    const locked = until > Date.now();
    nickInput.readOnly = locked;
    if (saveBtn) {
        saveBtn.disabled = locked;
        saveBtn.title = locked ? 'Emri është i ruajtur dhe i bllokuar për 10 ditë' : '';
    }
    if (hintEl) {
        if (locked) {
            const d = new Date(until);
            const fmt = d.toLocaleDateString('sq-AL', { day: 'numeric', month: 'long', year: 'numeric' });
            hintEl.textContent = `Emri ose nofka është e bllokuar deri më ${fmt}. Deri atëherë nuk mund ta ndërroni.`;
            hintEl.hidden = false;
        } else {
            hintEl.textContent = '';
            hintEl.hidden = true;
        }
    }
    if (locked) {
        const saved = localStorage.getItem(CHAT_NICK_KEY);
        if (saved) nickInput.value = saved;
    }
    syncChatNickCountdownUI();
}

function unlockChatNickLockUIOnly() {
    const nickInput = document.getElementById('chatNickname');
    const saveBtn = document.getElementById('chatSaveNickBtn');
    const hintEl = document.getElementById('chatNickLockHint');
    if (!nickInput) return;
    nickInput.readOnly = false;
    if (saveBtn) {
        saveBtn.disabled = false;
        saveBtn.title = '';
    }
    if (hintEl) {
        hintEl.textContent = '';
        hintEl.hidden = true;
    }
    const box = document.getElementById('chatNickCountdown');
    if (box) box.hidden = true;
    const msgs = document.getElementById('chatMessages');
    if (msgs) renderChatMessages(msgs);
}

function syncChatNickCountdownUI() {
    if (chatNickCountdownIntervalId) {
        clearInterval(chatNickCountdownIntervalId);
        chatNickCountdownIntervalId = null;
    }
    const box = document.getElementById('chatNickCountdown');
    if (!box) return;

    const dEl = document.getElementById('chatCountdownDays');
    const mEl = document.getElementById('chatCountdownMins');
    const sEl = document.getElementById('chatCountdownSecs');

    const updateDigits = () => {
        const until = getChatNickLockUntilMs();
        const L = until - Date.now();
        if (L <= 0) {
            box.hidden = true;
            if (dEl) dEl.textContent = '0';
            if (mEl) mEl.textContent = '00';
            if (sEl) sEl.textContent = '00';
            unlockChatNickLockUIOnly();
            return false;
        }
        const dayMs = 24 * 60 * 60 * 1000;
        const days = Math.floor(L / dayMs);
        const rem = L % dayMs;
        const mins = Math.floor((rem % 3600000) / 60000);
        const secs = Math.floor((rem % 60000) / 1000);
        if (dEl) dEl.textContent = String(days);
        if (mEl) mEl.textContent = String(mins).padStart(2, '0');
        if (sEl) sEl.textContent = String(secs).padStart(2, '0');
        box.hidden = false;
        return true;
    };

    if (!isChatNickLocked()) {
        box.hidden = true;
        return;
    }
    if (!updateDigits()) {
        return;
    }
    chatNickCountdownIntervalId = setInterval(() => {
        if (updateDigits() === false) {
            if (chatNickCountdownIntervalId) {
                clearInterval(chatNickCountdownIntervalId);
                chatNickCountdownIntervalId = null;
            }
        }
    }, 1000);
}

function getOrCreateChatOwnerId() {
    let id = localStorage.getItem(CHAT_OWNER_KEY);
    if (!id) {
        id = typeof crypto !== 'undefined' && crypto.randomUUID
            ? crypto.randomUUID()
            : `${Date.now()}-${Math.random().toString(36).slice(2, 12)}`;
        localStorage.setItem(CHAT_OWNER_KEY, id);
    }
    return id;
}

function canDeleteChatMessage(m) {
    if (!m) return false;
    if (m.ownerId) {
        const stored = localStorage.getItem(CHAT_OWNER_KEY);
        return !!stored && m.ownerId === stored;
    }
    const myNick = (localStorage.getItem(CHAT_NICK_KEY) || '').trim();
    const nickField = document.getElementById('chatNickname');
    const fromField = (nickField && nickField.value) ? nickField.value.trim() : '';
    const effectiveNick = fromField || myNick;
    if (!effectiveNick) return false;
    return (m.author || 'Anonim').trim() === effectiveNick;
}

function loadChatMessages() {
    try {
        const raw = localStorage.getItem(CHAT_STORAGE_KEY);
        const parsed = raw ? JSON.parse(raw) : [];
        const list = Array.isArray(parsed) ? parsed : [];
        let needsSave = false;
        const withIds = list.map((m) => {
            if (m && m.id) return m;
            needsSave = true;
            return {
                ...m,
                id: typeof crypto !== 'undefined' && crypto.randomUUID
                    ? crypto.randomUUID()
                    : `${Date.now()}-${Math.random().toString(36).slice(2, 10)}`
            };
        });
        if (needsSave) {
            saveChatMessages(withIds);
        }
        return withIds;
    } catch (e) {
        return [];
    }
}

function saveChatMessages(messages) {
    const trimmed = messages.slice(-200);
    localStorage.setItem(CHAT_STORAGE_KEY, JSON.stringify(trimmed));
}

function isChatSafeDataUrl(u) {
    if (typeof u !== 'string' || u.length < 16 || !u.startsWith('data:')) return false;
    if (/^data:text\/html/i.test(u)) return false;
    return /^data:(image\/|video\/|application\/|audio\/|text\/plain)/i.test(u);
}

function safeChatDownloadName(name) {
    return String(name || 'skedar').replace(/[<>:"/\\|?*\u0000-\u001f]/g, '_').slice(0, 120);
}

function renderChatMessageAttachments(m) {
    const list = m && m.attachments;
    if (!Array.isArray(list) || !list.length) return '';
    const parts = list.map((a) => {
        if (!a || !a.dataUrl || !isChatSafeDataUrl(a.dataUrl)) return '';
        const name = escapeChatHtml(a.name || 'skedar');
        const dlName = escapeChatHtml(safeChatDownloadName(a.name));
        const mime = String(a.mime || '').toLowerCase();
        const url = a.dataUrl;
        if (mime.startsWith('image/')) {
            return `<div class="chat-attach-block"><img src="${url}" alt="${name}" class="chat-attach-img" loading="lazy"></div>`;
        }
        if (mime.startsWith('video/')) {
            return `<div class="chat-attach-block"><video src="${url}" class="chat-attach-video" controls playsinline preload="metadata"></video></div>`;
        }
        return `<div class="chat-attach-block chat-attach-file"><a class="chat-attach-link" href="${url}" download="${dlName}" target="_blank" rel="noopener noreferrer">Shkarko: ${name}</a></div>`;
    });
    const inner = parts.filter(Boolean).join('');
    return inner ? `<div class="chat-attach-list">${inner}</div>` : '';
}

function readChatFileAsDataAttachment(file, onDone, onErr) {
    const r = new FileReader();
    r.onload = () => {
        onDone({
            name: file.name || 'skedar',
            mime: file.type || 'application/octet-stream',
            dataUrl: r.result
        });
    };
    r.onerror = () => {
        if (onErr) onErr();
    };
    r.readAsDataURL(file);
}

function renderChatMessages(container) {
    if (!container) return;
    const messages = loadChatMessages();
    if (!messages.length) {
        container.innerHTML = '<p style="color: var(--text-muted); font-size: 0.9rem; font-style: italic;">Ende nuk ka mesazhe. Filloni bisedën.</p>';
        return;
    }
    container.innerHTML = messages.map((m) => {
        const deletable = canDeleteChatMessage(m);
        const delBtn = deletable
            ? `<button type="button" class="chat-delete-btn" data-msg-id="${escapeChatHtml(m.id)}" title="Fshi mesazhin">Fshi</button>`
            : '';
        return `
        <div class="chat-bubble" data-msg-id="${escapeChatHtml(m.id)}">
            <div class="chat-bubble-head">
            <div class="chat-bubble-meta">${escapeChatHtml(m.author || 'Anonim')}</div>
            ${delBtn}
            </div>
            <div class="chat-bubble-body">${escapeChatHtml(m.text || '')}</div>
            ${renderChatMessageAttachments(m)}
            <div class="chat-bubble-time">${escapeChatHtml(m.time || '')}</div>
        </div>
    `;
    }).join('');
    container.scrollTop = container.scrollHeight;
}

function initCommunityChat() {
    const container = document.getElementById('chatMessages');
    const form = document.getElementById('chatForm');
    const nickInput = document.getElementById('chatNickname');
    const msgInput = document.getElementById('chatMessageInput');
    const saveNickBtn = document.getElementById('chatSaveNickBtn');
    const nickHint = document.getElementById('chatNickLockHint');
    if (!container || !form || !nickInput || !msgInput) return;

    const savedNick = localStorage.getItem(CHAT_NICK_KEY);
    if (savedNick) nickInput.value = savedNick;
    applyChatNickLockUI(nickInput, saveNickBtn, nickHint);

    if (saveNickBtn) {
        saveNickBtn.addEventListener('click', () => {
            if (isChatNickLocked()) {
                alert('Emri ose nofka juaj është ende e bllokuar. Nuk mund ta ndërroni deri në skadimin e periudhës.');
                applyChatNickLockUI(nickInput, saveNickBtn, nickHint);
                return;
            }
            const name = nickInput.value.trim();
            if (!name) {
                alert('Ju lutem shkruani emrin ose nofkën para se ta ruani.');
                return;
            }
            localStorage.setItem(CHAT_NICK_KEY, name);
            localStorage.setItem(CHAT_NICK_LOCK_UNTIL_KEY, String(Date.now() + CHAT_NICK_LOCK_MS));
            applyChatNickLockUI(nickInput, saveNickBtn, nickHint);
            renderChatMessages(container);
            alert('Emri u ruajt.\n\nPër 10 ditë nuk mund ta ndërroni emrin në këtë pajisje.');
        });
    }

    window.addEventListener('focus', () => {
        applyChatNickLockUI(nickInput, saveNickBtn, nickHint);
    });

    let lastChatSnapshot = localStorage.getItem(CHAT_STORAGE_KEY) || '';
    renderChatMessages(container);

    const deleteFromChat = (id) => {
        if (!id) return;
        const messages = loadChatMessages();
        const next = messages.filter((m) => m && m.id !== id);
        if (next.length === messages.length) return;
        saveChatMessages(next);
        lastChatSnapshot = localStorage.getItem(CHAT_STORAGE_KEY) || '';
        renderChatMessages(container);
    };

    container.addEventListener('click', (e) => {
        const btn = e.target && e.target.closest && e.target.closest('.chat-delete-btn');
        if (!btn) return;
        e.preventDefault();
        const id = btn.getAttribute('data-msg-id');
        if (id == null) return;
        const msg = loadChatMessages().find((x) => x && x.id === id);
        if (!msg || !canDeleteChatMessage(msg)) return;
        deleteFromChat(id);
    });

    ['input', 'change'].forEach((ev) => {
        nickInput.addEventListener(ev, () => {
            const snap = lastChatSnapshot;
            renderChatMessages(container);
            lastChatSnapshot = snap;
        });
    });

    window.addEventListener('storage', (e) => {
        if (e.key === CHAT_STORAGE_KEY) {
            lastChatSnapshot = localStorage.getItem(CHAT_STORAGE_KEY) || '';
            renderChatMessages(container);
        }
    });

    setInterval(() => {
        const snap = localStorage.getItem(CHAT_STORAGE_KEY) || '';
        if (snap !== lastChatSnapshot) {
            lastChatSnapshot = snap;
            renderChatMessages(container);
        }
    }, 2000);

    const previewEl = document.getElementById('chatAttachmentPreview');
    const filePhoto = document.getElementById('chatFilePhoto');
    const fileVideo = document.getElementById('chatFileVideo');
    const fileAny = document.getElementById('chatFileAny');
    const btnPhoto = document.getElementById('chatAttachPhoto');
    const btnVideo = document.getElementById('chatAttachVideo');
    const btnFile = document.getElementById('chatAttachFile');

    let stagedChatAttachments = [];

    const renderStagedPreview = () => {
        if (!previewEl) return;
        if (!stagedChatAttachments.length) {
            previewEl.innerHTML = '';
            return;
        }
        previewEl.innerHTML = stagedChatAttachments.map((a, i) => `
            <div class="chat-staged-chip">
                <span class="chat-staged-name">${escapeChatHtml(a.name)}</span>
                <button type="button" class="chat-staged-remove" data-staged-idx="${i}" title="Hiq">×</button>
            </div>
        `).join('');
    };

    const handleIncomingChatFiles = (fileList, inputEl) => {
        const files = Array.from(fileList || []);
        if (inputEl) inputEl.value = '';
        for (const file of files) {
            if (stagedChatAttachments.length >= CHAT_ATTACH_MAX_FILES) {
                alert(`Maksimumi është ${CHAT_ATTACH_MAX_FILES} skedarë për një mesazh.`);
                break;
            }
            if (file.size > CHAT_ATTACH_MAX_BYTES) {
                alert(`Skedari "${file.name}" tejkalon ${(CHAT_ATTACH_MAX_BYTES / (1024 * 1024)).toFixed(1)} MB. Zgjidhni një skedar më të vogël.`);
                continue;
            }
            readChatFileAsDataAttachment(
                file,
                (att) => {
                    if (stagedChatAttachments.length >= CHAT_ATTACH_MAX_FILES) return;
                    stagedChatAttachments.push(att);
                    renderStagedPreview();
                },
                () => alert('Leximi i skedarit dështoi.')
            );
        }
    };

    if (previewEl) {
        previewEl.addEventListener('click', (e) => {
            const btn = e.target && e.target.closest && e.target.closest('.chat-staged-remove');
            if (!btn) return;
            const idx = parseInt(btn.getAttribute('data-staged-idx'), 10);
            if (!Number.isFinite(idx)) return;
            stagedChatAttachments.splice(idx, 1);
            renderStagedPreview();
        });
    }

    if (btnPhoto && filePhoto) btnPhoto.addEventListener('click', () => filePhoto.click());
    if (btnVideo && fileVideo) btnVideo.addEventListener('click', () => fileVideo.click());
    if (btnFile && fileAny) btnFile.addEventListener('click', () => fileAny.click());
    if (filePhoto) filePhoto.addEventListener('change', () => handleIncomingChatFiles(filePhoto.files, filePhoto));
    if (fileVideo) fileVideo.addEventListener('change', () => handleIncomingChatFiles(fileVideo.files, fileVideo));
    if (fileAny) fileAny.addEventListener('change', () => handleIncomingChatFiles(fileAny.files, fileAny));

    form.onsubmit = (e) => {
        e.preventDefault();
        const author = (isChatNickLocked()
            ? (localStorage.getItem(CHAT_NICK_KEY) || '').trim()
            : nickInput.value.trim()) || 'Anonim';
        const text = msgInput.value.trim();
        const attachments = stagedChatAttachments.map((a) => ({
            name: a.name,
            mime: a.mime,
            dataUrl: a.dataUrl
        }));
        if (!text && !attachments.length) {
            alert('Shkruani mesazh ose shtoni të paktën një foto, video ose skedar.');
            return;
        }

        if (!isChatNickLocked()) {
            localStorage.setItem(CHAT_NICK_KEY, author);
        }

        const msg = {
            id: Date.now().toString(),
            ownerId: getOrCreateChatOwnerId(),
            author,
            text,
            time: new Date().toLocaleString('sq-AL', { dateStyle: 'short', timeStyle: 'short' })
        };
        if (attachments.length) {
            msg.attachments = attachments;
        }

        const messages = loadChatMessages();
        messages.push(msg);
        try {
            saveChatMessages(messages);
        } catch (err) {
            alert('Nuk u ruajt: hapësira lokale e shfletuesit është e plotë ose mesazhi është shumë i madh. Provoni skedarë më të vegjël ose hiqni disa mesazhe të vjetra.');
            return;
        }
        lastChatSnapshot = localStorage.getItem(CHAT_STORAGE_KEY) || '';
        stagedChatAttachments = [];
        renderStagedPreview();
        msgInput.value = '';
        renderChatMessages(container);
    };
}

function initVillageLagjjaSelector() {
    const villageHiddenInput = document.getElementById('village');
    const villageSelect = document.getElementById('villageSelect');
    const lagjjaInput = document.getElementById('lagjjaInput');
    const modeFshatBtn = document.getElementById('modeFshatBtn');
    const modeLagjjaBtn = document.getElementById('modeLagjjaBtn');

    if (!villageHiddenInput || !villageSelect || !lagjjaInput || !modeFshatBtn || !modeLagjjaBtn) return;

    const villagesSorted = [...GJILAN_VILLAGES].sort((a, b) => a.localeCompare(b, 'sq'));
    villageSelect.innerHTML = '<option value="">Zgjidhni fshatin e Gjilanit...</option>' +
        villagesSorted.map((name) => `<option value="${name}">${name}</option>`).join('');

    const activateFshatMode = () => {
        villageSelect.style.display = 'block';
        lagjjaInput.style.display = 'none';
        modeFshatBtn.classList.add('btn-primary');
        modeFshatBtn.classList.remove('btn-ghost');
        modeLagjjaBtn.classList.add('btn-ghost');
        modeLagjjaBtn.classList.remove('btn-primary');
        villageHiddenInput.value = villageSelect.value || '';
    };

    const activateLagjjaMode = () => {
        villageSelect.style.display = 'none';
        lagjjaInput.style.display = 'block';
        modeLagjjaBtn.classList.add('btn-primary');
        modeLagjjaBtn.classList.remove('btn-ghost');
        modeFshatBtn.classList.add('btn-ghost');
        modeFshatBtn.classList.remove('btn-primary');
        villageHiddenInput.value = lagjjaInput.value.trim();
    };

    modeFshatBtn.onclick = activateFshatMode;
    modeLagjjaBtn.onclick = activateLagjjaMode;
    villageSelect.onchange = () => {
        villageHiddenInput.value = villageSelect.value || '';
    };
    lagjjaInput.oninput = () => {
        villageHiddenInput.value = lagjjaInput.value.trim();
    };

    activateFshatMode();
}

function initLocationPicker() {
    const pickerBtn = document.getElementById('openLocationPickerBtn');
    if (!pickerBtn) return;

    const openPicker = () => window.open('mapa-gjilan.html', '_blank');
    pickerBtn.onclick = openPicker;

    applyPickedLocationFromStorage();
    window.addEventListener('focus', applyPickedLocationFromStorage);
}

function applyPickedLocationFromStorage() {
    const payload = localStorage.getItem(LOCATION_PICK_KEY);
    if (!payload) return;

    try {
        const picked = JSON.parse(payload);
        const exactLocationInput = document.getElementById('exactLocation');
        const latInput = document.getElementById('locationLat');
        const lngInput = document.getElementById('locationLng');
        const streetInput = document.getElementById('locationStreet');
        const label = document.getElementById('selectedLocationLabel');

        if (exactLocationInput) exactLocationInput.value = picked.address || '';
        if (latInput) latInput.value = String(picked.lat || '');
        if (lngInput) lngInput.value = String(picked.lng || '');
        if (streetInput) streetInput.value = picked.streetName || '';
        if (label) {
            label.textContent = picked.address ? `Lokacioni i zgjedhur: ${picked.address}` : 'Asnjë vendndodhje e zgjedhur.';
            label.style.color = picked.address ? '#16a34a' : '#64748b';
        }
    } catch (err) {
        console.error('Nuk u lexua lokacioni i zgjedhur:', err);
    }

    localStorage.removeItem(LOCATION_PICK_KEY);
}

function clearPickedLocationPreview() {
    const exactLocationInput = document.getElementById('exactLocation');
    const latInput = document.getElementById('locationLat');
    const lngInput = document.getElementById('locationLng');
    const streetInput = document.getElementById('locationStreet');
    const label = document.getElementById('selectedLocationLabel');

    if (exactLocationInput) exactLocationInput.value = '';
    if (latInput) latInput.value = '';
    if (lngInput) lngInput.value = '';
    if (streetInput) streetInput.value = '';
    if (label) {
        label.textContent = 'Asnjë vendndodhje e zgjedhur.';
        label.style.color = '#64748b';
    }
}

function updateList() {
    const reportsList = document.getElementById('reportsList');
    if (!reportsList) return;
    
    const pageType = document.body.dataset.page;
    const filtered = currentReports.filter(r => r.type === pageType);
    
    reportsList.innerHTML = '';
    
    if (filtered.length === 0) {
        reportsList.innerHTML = '<div class="card" style="text-align: center; color: #94a3b8; font-style: italic;">Nuk keni asnjë raport të ruajtur.</div>';
        return;
    }

    filtered.forEach(report => {
        const item = document.createElement('div');
        item.className = 'report-item';
        item.innerHTML = `
            <div class="report-header">
                <span class="type-tag tag-${report.type}">${report.type === 'request' ? 'Kërkesë' : 'Ankesë'}</span>
                <span style="font-size: 0.7rem; color: #94a3b8; font-weight: 700;">${report.date}</span>
            </div>
            <h4 style="font-weight: 800; margin-bottom: 0.5rem;">Komuna e ${report.municipality} ${report.village !== 'Nuk ka' ? '(' + report.village + ')' : ''}</h4>
            <p style="font-size: 0.8rem; color: #64748b; margin-bottom: 0.5rem;"><b>Lokacioni:</b> ${report.exactLocation}</p>
            <p style="font-size: 0.85rem; color: #64748b; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; margin-bottom: 1rem;">${report.content}</p>
            <div style="display: flex; gap: 0.5rem; justify-content: flex-end;">
                <button class="btn btn-ghost btn-view-full" data-id="${report.id}" style="font-size: 0.75rem; padding: 0.4rem 0.8rem;">Shiko Plotë</button>
                <button class="btn btn-primary btn-download-item-pdf" data-id="${report.id}" style="font-size: 0.75rem; padding: 0.4rem 0.8rem;">Shkarko si PDF</button>
                <button class="btn btn-danger btn-delete-item" data-id="${report.id}" style="font-size: 0.75rem; padding: 0.4rem 0.8rem;">Fshije</button>
            </div>
        `;
        reportsList.appendChild(item);
    });

    document.querySelectorAll('.btn-view-full').forEach(btn => {
        btn.onclick = () => openReportDetail(btn.dataset.id);
    });
    document.querySelectorAll('.btn-download-item-pdf').forEach(btn => {
        btn.onclick = () => {
            const report = currentReports.find(r => r.id === btn.dataset.id);
            if (!report) return;
            downloadReportPdf(report);
        };
    });
    document.querySelectorAll('.btn-delete-item').forEach(btn => {
        btn.onclick = () => {
            const reportId = btn.dataset.id;
            if (!reportId) return;
            if (!confirm('A jeni të sigurt që dëshironi ta fshini këtë kërkesë?')) return;
            currentReports = currentReports.filter(r => r.id !== reportId);
            saveReports();
            updateList();
        };
    });
}

function openReportDetail(id) {
    const report = currentReports.find(r => r.id === id);
    if (!report) return;
    if (!detailModal) detailModal = document.getElementById('detailModal');
    
    activeItem = report;
    
    const badge = document.getElementById('modalTypeBadge');
    badge.className = `type-tag tag-${report.type}`;
    badge.textContent = report.type === 'request' ? 'Kërkesë' : 'Ankesë';
    
    document.getElementById('modalTitle').textContent = `Raporti: Komuna e ${report.municipality}`;
    document.getElementById('modalDate').textContent = `Raportuar më: ${report.date} në ora ${report.time}`;
    
    const detailsHtml = `
        <div class="detail-grid">
            <div class="detail-box">
                <label>Komuna</label>
                <span>${report.municipality}</span>
            </div>
            <div class="detail-box">
                <label>Fshati / Lagjja</label>
                <span>${report.village}</span>
            </div>
            <div class="detail-box">
                <label>Data e Incidentit</label>
                <span>${report.eventDate}</span>
            </div>
            <div class="detail-box">
                <label>Lokacioni Ekzakt</label>
                <span>${report.exactLocation}</span>
            </div>
        </div>
        <div class="detail-box" style="margin-bottom: 2rem;">
            <label>Përshkrimi i Plotë</label>
            <div style="font-style: italic; color: var(--text-main); white-space: pre-wrap; font-size: 0.95rem; margin-top: 8px;">${report.content}</div>
        </div>
    `;
    
    document.getElementById('modalBody').innerHTML = detailsHtml;
    detailModal?.classList.add('active');
}

function readCachedGjilanStreetNames() {
    try {
        const raw = localStorage.getItem(GJILAN_STREETS_CACHE_KEY);
        if (!raw) return null;
        const parsed = JSON.parse(raw);
        if (!parsed || typeof parsed.t !== 'number' || !Array.isArray(parsed.names)) return null;
        if (Date.now() - parsed.t > GJILAN_STREETS_CACHE_MAX_AGE_MS) return null;
        return parsed.names.filter((n) => typeof n === 'string' && n.trim());
    } catch {
        return null;
    }
}

function writeCachedGjilanStreetNames(names) {
    try {
        if (!names || !names.length) return;
        localStorage.setItem(GJILAN_STREETS_CACHE_KEY, JSON.stringify({ t: Date.now(), names }));
    } catch {
        // Hapësira e localStorage e plotë — injoro
    }
}

function collectStreetNamesFromOverpassElements(elements) {
    const out = new Set();
    for (const el of elements || []) {
        const t = el && el.tags;
        if (!t || !t.highway) continue;
        const primary = t.name || t['name:sq'] || t['name:sr'] || t.loc_name;
        if (primary) out.add(String(primary).trim());
        const alt = t.alt_name || t.old_name;
        if (alt) {
            String(alt)
                .split(/[;|]/)
                .map((s) => s.trim())
                .filter(Boolean)
                .forEach((p) => out.add(p));
        }
    }
    return [...out].sort((a, b) => a.localeCompare(b, 'sq'));
}

function pickerStreetFirstLetter(name) {
    const s = String(name || '').trim();
    if (!s) return '?';
    return s.charAt(0).toLocaleUpperCase('sq');
}

function buildGjilanStreetAlphabetRowsHtml(names) {
    if (!names || !names.length) {
        return '<p class="street-pick-empty">Nuk u gjetën emra rrugësh. Provoni përsëri më vonë ose zgjidhni një pikë në hartë.</p>';
    }
    const sorted = [...names].sort((a, b) => String(a).localeCompare(String(b), 'sq'));
    const groups = new Map();
    sorted.forEach((name) => {
        const L = pickerStreetFirstLetter(name);
        if (!groups.has(L)) groups.set(L, []);
        groups.get(L).push(name);
    });
    const letters = [...groups.keys()].sort((a, b) => a.localeCompare(b, 'sq'));
    const rows = [];
    letters.forEach((letter) => {
        const streets = groups.get(letter);
        streets.forEach((name, idx) => {
            const letterInner = idx === 0
                ? `<span class="street-pick-letter" aria-hidden="true">${escapeChatHtml(letter)}</span>`
                : '<span class="street-pick-letter street-pick-letter--spacer" aria-hidden="true"></span>';
            const enc = encodeURIComponent(name);
            rows.push(
                `<div class="street-pick-row" role="option">` +
                `<div class="street-pick-letter-cell">${letterInner}</div>` +
                `<button type="button" class="street-pick-name-btn" data-street="${enc}">${escapeChatHtml(name)}</button>` +
                `</div>`
            );
        });
    });
    return rows.join('');
}

function initMapPickerPage() {
    const mapContainer = document.getElementById('mapPickerCanvas');
    if (!mapContainer || typeof L === 'undefined') return;

    const gjilanCenter = [42.4637, 21.4694];
    const map = L.map(mapContainer, {
        maxZoom: 18,
        minZoom: 11
    }).setView(gjilanCenter, 13);
    map._allStreetNames = readCachedGjilanStreetNames() || [];
    const streetLayer = L.tileLayer('https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png', {
        maxZoom: 18,
        attribution: '&copy; OpenStreetMap contributors &copy; CARTO'
    }).addTo(map);
    const satelliteBaseLayer = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
        maxZoom: 18,
        attribution: 'Tiles &copy; Esri'
    });
    const satelliteRoadsLayer = L.tileLayer('https://services.arcgisonline.com/ArcGIS/rest/services/Reference/World_Transportation/MapServer/tile/{z}/{y}/{x}', {
        maxZoom: 18,
        attribution: 'Roads &copy; Esri'
    });
    const satelliteLabelsLayer = L.tileLayer('https://services.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/MapServer/tile/{z}/{y}/{x}', {
        maxZoom: 18,
        attribution: 'Labels &copy; Esri'
    });
    const satelliteLayer = L.layerGroup([satelliteBaseLayer, satelliteRoadsLayer, satelliteLabelsLayer]);
    L.control.layers(
        { 'Rruge': streetLayer, 'Satelit': satelliteLayer },
        {},
        { position: 'topright' }
    ).addTo(map);

    const gjilanBounds = L.latLngBounds([42.33, 21.32], [42.58, 21.62]);
    map.setMaxBounds(gjilanBounds);
    map.options.maxBoundsViscosity = 1.0;
    map.setZoom(13);
    map.on('moveend', () => {
        if (!gjilanBounds.contains(map.getCenter())) {
            map.panInsideBounds(gjilanBounds, { animate: true });
        }
    });

    let marker = null;
    let selected = null;
    const dangerDogIcon = L.divIcon({
        className: 'danger-dog-icon',
        html: '<div style="font-size: 24px; line-height: 1;">⚠️🐕</div>',
        iconSize: [28, 28],
        iconAnchor: [14, 24]
    });

    const selectedLabel = document.getElementById('mapSelectedLabel');
    const continueBtn = document.getElementById('mapContinueBtn');
    const streetLoadInfo = document.getElementById('streetLoadInfo');
    const streetAlphabetList = document.getElementById('gjilanStreetAlphabetList');
    const openStreetPickBtn = document.getElementById('openStreetPickBtn');
    const closeStreetPickBtn = document.getElementById('closeStreetPickBtn');
    const streetPickPanel = document.getElementById('streetPickPanel');

    const setStreetPanelOpen = (open) => {
        if (!streetPickPanel) return;
        streetPickPanel.hidden = !open;
        if (openStreetPickBtn) openStreetPickBtn.setAttribute('aria-expanded', open ? 'true' : 'false');
    };

    const renderAlphabetStreetList = () => {
        if (!streetAlphabetList) return;
        const names = Array.isArray(map._allStreetNames) ? map._allStreetNames : [];
        streetAlphabetList.innerHTML = buildGjilanStreetAlphabetRowsHtml(names);
    };

    if (streetAlphabetList) {
        streetAlphabetList.addEventListener('click', (e) => {
            const btn = e.target && e.target.closest && e.target.closest('.street-pick-name-btn');
            if (!btn) return;
            const name = decodeURIComponent(btn.getAttribute('data-street') || '');
            if (!name) return;
            geocodeWithFallback(name).then((found) => {
                if (!found) {
                    if (selectedLabel) {
                        selectedLabel.textContent = 'Nuk u gjet vendndodhja për këtë rrugë. Provoni nga harta.';
                    }
                    return;
                }
                setSelection(found.lat, found.lng, found.address, found.streetName || '');
                setStreetPanelOpen(false);
            }).catch(() => {
                if (selectedLabel) selectedLabel.textContent = 'Gabim gjatë kërkimit të lokacionit. Provoni përsëri.';
            });
        });
    }

    if (openStreetPickBtn) {
        openStreetPickBtn.addEventListener('click', () => {
            setStreetPanelOpen(true);
            renderAlphabetStreetList();
            const haveNames = Array.isArray(map._allStreetNames) && map._allStreetNames.length > 0;
            if (!haveNames) {
                if (streetLoadInfo) streetLoadInfo.textContent = 'Po ringarkohen emrat e rrugëve…';
                loadGjilanStreetNames().catch(() => {
                    if (streetLoadInfo) {
                        streetLoadInfo.textContent =
                            'Lista e rrugëve nuk u ngarkua. Kontrolloni lidhjen me internetin ose zgjidhni një pikë në hartë.';
                    }
                    renderAlphabetStreetList();
                });
            }
        });
    }
    if (closeStreetPickBtn) {
        closeStreetPickBtn.addEventListener('click', () => setStreetPanelOpen(false));
    }

    const setSelection = (lat, lng, address, streetName = '') => {
        if (marker) map.removeLayer(marker);
        marker = L.marker([lat, lng], { icon: dangerDogIcon }).addTo(map);
        map.setView([lat, lng], 16);
        selected = { lat, lng, address, streetName };
        if (selectedLabel) selectedLabel.textContent = `Vendndodhja e zgjedhur: ${address}`;
    };

    const geocodeWithFallback = async (term) => {
        const encoded = encodeURIComponent(`${term}, Gjilan, Kosovo`);
        const providers = [
            `https://geocode.maps.co/search?q=${encoded}`,
            `https://nominatim.openstreetmap.org/search?format=json&limit=1&q=${encoded}`
        ];

        for (const url of providers) {
            try {
                const response = await fetch(url);
                if (!response.ok) continue;
                const results = await response.json();
                if (!results || !results.length) continue;
                const first = results[0];
                const lat = parseFloat(first.lat);
                const lng = parseFloat(first.lon);
                const address = first.display_name || `${lat.toFixed(5)}, ${lng.toFixed(5)}`;
                const streetName = first.address?.road || first.address?.pedestrian || first.address?.neighbourhood || '';
                return { lat, lng, address, streetName };
            } catch (err) {
                // Try next provider
            }
        }
        return null;
    };

    const reverseGeocodeWithFallback = async (lat, lng) => {
        const providers = [
            `https://geocode.maps.co/reverse?lat=${lat}&lon=${lng}`,
            `https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lng}`
        ];

        for (const url of providers) {
            try {
                const response = await fetch(url);
                if (!response.ok) continue;
                const data = await response.json();
                if (!data) continue;
                return {
                    address: data.display_name || `${lat.toFixed(5)}, ${lng.toFixed(5)}`,
                    streetName: data.address?.road || data.address?.pedestrian || data.address?.neighbourhood || ''
                };
            } catch (err) {
                // Try next provider
            }
        }
        return { address: `${lat.toFixed(5)}, ${lng.toFixed(5)}`, streetName: '' };
    };

    const loadGjilanStreetNames = async () => {
        const sw = gjilanBounds.getSouthWest();
        const ne = gjilanBounds.getNorthEast();
        const bbox = `${sw.lat},${sw.lng},${ne.lat},${ne.lng}`;
        const overpassQuery = `
            [out:json][timeout:90];
            (
              way["highway"]["name"](${bbox});
              way["highway"]["name:sq"](${bbox});
              way["highway"]["name:sr"](${bbox});
            );
            out tags;
        `;
        const body = `data=${encodeURIComponent(overpassQuery)}`;
        const endpoints = [
            'https://overpass-api.de/api/interpreter',
            'https://lz4.overpass-api.de/api/interpreter',
            'https://overpass.kumi.systems/api/interpreter'
        ];
        let data = null;
        let lastErr = null;
        for (const url of endpoints) {
            try {
                const response = await fetch(url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                    body,
                    mode: 'cors'
                });
                if (!response.ok) continue;
                data = await response.json();
                break;
            } catch (err) {
                lastErr = err;
            }
        }
        if (!data) throw lastErr || new Error('Overpass unavailable');
        const names = collectStreetNamesFromOverpassElements(data.elements);
        if (!names.length) throw new Error('No street names in Overpass response');
        map._allStreetNames = names;
        writeCachedGjilanStreetNames(names);
        if (streetLoadInfo) {
            streetLoadInfo.textContent = `U ngarkuan ${names.length} emra rrugësh (brenda zonës së hartës).`;
        }
        if (streetPickPanel && !streetPickPanel.hidden) {
            renderAlphabetStreetList();
        }
    };

    map.on('click', async (e) => {
        const { lat, lng } = e.latlng;
        const resolved = await reverseGeocodeWithFallback(lat, lng);
        setSelection(lat, lng, resolved.address, resolved.streetName || '');
    });

    if (continueBtn) {
        continueBtn.onclick = () => {
            if (!selected) {
                alert('Ju lutem zgjidhni një vendndodhje para se të vazhdoni.');
                return;
            }

            localStorage.setItem(LOCATION_PICK_KEY, JSON.stringify(selected));
            if (window.opener && !window.opener.closed) {
                window.opener.focus();
                window.close();
            } else {
                window.location.href = 'kerkesat.html';
            }
        };
    }

    loadGjilanStreetNames().catch(() => {
        const fallback = readCachedGjilanStreetNames();
        if (fallback && fallback.length) {
            map._allStreetNames = fallback;
            if (streetLoadInfo) {
                streetLoadInfo.textContent = `Po përdoren ${fallback.length} emra të ruajtur lokalisht (pa lidhje të re me serverin).`;
            }
            if (streetPickPanel && !streetPickPanel.hidden) renderAlphabetStreetList();
        } else if (streetLoadInfo) {
            streetLoadInfo.textContent =
                'Lista e rrugëve nuk u ngarkua tani. Hapni «Zgjidhni Vendndodhjen…» përsëri ose zgjidhni një pikë në hartë.';
        }
    });
}

function initRiskMapHome() {
    const mapContainer = document.getElementById('riskMapHome');
    if (!mapContainer || typeof L === 'undefined') return;

    const map = L.map(mapContainer, {
        maxZoom: 18,
        minZoom: 10
    }).setView([42.4637, 21.4694], 12);
    const gjilanBounds = L.latLngBounds([42.33, 21.32], [42.58, 21.62]);
    map.setMaxBounds(gjilanBounds);
    map.options.maxBoundsViscosity = 1.0;
    map.on('moveend', () => {
        if (!gjilanBounds.contains(map.getCenter())) {
            map.panInsideBounds(gjilanBounds, { animate: true });
        }
    });
    const streetLayer = L.tileLayer('https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png', {
        maxZoom: 18,
        attribution: '&copy; OpenStreetMap contributors &copy; CARTO'
    }).addTo(map);
    const satelliteBaseLayer = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
        maxZoom: 18,
        attribution: 'Tiles &copy; Esri'
    });
    const satelliteRoadsLayer = L.tileLayer('https://services.arcgisonline.com/ArcGIS/rest/services/Reference/World_Transportation/MapServer/tile/{z}/{y}/{x}', {
        maxZoom: 18,
        attribution: 'Roads &copy; Esri'
    });
    const satelliteLabelsLayer = L.tileLayer('https://services.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/MapServer/tile/{z}/{y}/{x}', {
        maxZoom: 18,
        attribution: 'Labels &copy; Esri'
    });
    const satelliteLayer = L.layerGroup([satelliteBaseLayer, satelliteRoadsLayer, satelliteLabelsLayer]);
    L.control.layers(
        { 'Rruge': streetLayer, 'Satelit': satelliteLayer },
        {},
        { position: 'topright' }
    ).addTo(map);

    const note = document.getElementById('riskMapNote');
    const dangerDogIcon = L.divIcon({
        className: 'danger-dog-icon',
        html: '<div style="font-size: 24px; line-height: 1;">⚠️🐕</div>',
        iconSize: [28, 28],
        iconAnchor: [14, 24]
    });
    const gjilanReports = currentReports.filter((r) =>
        r.locationLat && r.locationLng && String(r.municipality || '').toLowerCase().includes('gjilan')
    );

    if (!gjilanReports.length) {
        if (note) note.textContent = 'Ende nuk ka pika të raportuara me lokacion në Gjilan.';
        return;
    }

    const getStreetName = (report) => {
        if (report.streetName) return report.streetName;
        if (!report.exactLocation) return 'Rruga e panjohur';
        return String(report.exactLocation).split(',')[0].trim();
    };

    gjilanReports.forEach((report) => {
        const marker = L.marker([report.locationLat, report.locationLng], { icon: dangerDogIcon }).addTo(map);
        marker.bindPopup(`
            <b>${report.type === 'request' ? 'Kërkesë' : 'Ankesë'} - ${report.municipality}</b><br>
            Rruga: ${getStreetName(report)}<br>
            ${report.date}
        `);
    });

    const group = L.featureGroup(gjilanReports.map((r) => L.marker([r.locationLat, r.locationLng], { icon: dangerDogIcon })));
    map.fitBounds(group.getBounds().pad(0.15));
    if (note) note.textContent = `Po shfaqen ${gjilanReports.length} pika rreziku në Gjilan.`;

    // Disabled manual point picking on homepage map.
    // The map now only displays locations submitted from Kërkesat.
}

// PDF Generation
const downloadBtn = document.getElementById('downloadPdfBtn');
if (downloadBtn) {
    downloadBtn.onclick = () => {
        if (!activeItem) return;
        downloadReportPdf(activeItem);
    };
}

function downloadReportPdf(report) {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();

    doc.setFontSize(22);
    doc.setTextColor(37, 99, 235);
    doc.text("MBROJTJA.KS", 20, 30);

    doc.setFontSize(10);
    doc.setTextColor(100, 116, 139);
    doc.text("Platforma Kombëtare e Sigurisë për Incidentet me Qentë Endacak", 20, 37);

    doc.setDrawColor(226, 232, 240);
    doc.line(20, 45, 190, 45);

    doc.setFontSize(16);
    doc.setTextColor(15, 23, 42);
    const typeLabel = report.type === 'request' ? 'KERKESE PER NDERHYRJE' : 'ANKESE PER NEGLIZHENCE';
    doc.text(typeLabel, 20, 60);

    doc.setFontSize(11);
    doc.text(`Komuna: ${report.municipality}`, 20, 75);
    doc.text(`Fshati: ${report.village}`, 20, 82);
    doc.text(`Data e Incidentit: ${report.eventDate}`, 20, 89);
    doc.text(`Lokacioni: ${report.exactLocation}`, 20, 96);
    doc.text(`Koha e Raportimit: ${report.date} ${report.time}`, 20, 103);

    doc.setFontSize(10);
    doc.setTextColor(100, 116, 139);
    doc.text("Pershkrimi i detajuar:", 20, 115);

    doc.setTextColor(51, 65, 85);
    const splitText = doc.splitTextToSize(report.content, 170);
    doc.text(splitText, 20, 125);

    doc.setFontSize(8);
    doc.setTextColor(148, 163, 184);
    doc.text("Ky raport eshte gjeneruar ne menyre automatike nga platforma Mbrojtja.ks", 20, 280);

    doc.save(`raporti_mbrojtja_${report.municipality}_${report.id}.pdf`);
}

// Delete Report
const deleteBtn = document.getElementById('deleteReportBtn');
if (deleteBtn) {
    deleteBtn.onclick = () => {
        if (!activeItem) return;
        if (!confirm('A jeni të sigurt që dëshironi ta fshini këtë raport?')) return;
        
        currentReports = currentReports.filter(r => r.id !== activeItem.id);
        saveReports();
        updateList();
        if (!detailModal) detailModal = document.getElementById('detailModal');
        detailModal?.classList.remove('active');
    };
}
