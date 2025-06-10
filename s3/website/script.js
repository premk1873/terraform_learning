let counter = 0;
    const counterDisplay = document.getElementById('counter');
    const increaseBtn = document.getElementById('increase');
    const decreaseBtn = document.getElementById('decrease');
    const resetBtn = document.getElementById('reset');

    function updateCounter() {
        counterDisplay.textContent = counter;
        counterDisplay.style.transform = 'scale(1.1)';
        setTimeout(() => {
            counterDisplay.style.transform = 'scale(1)';
        }, 200);
    }

    increaseBtn.addEventListener('click', () => {
        counter++;
        updateCounter();
    });

    decreaseBtn.addEventListener('click', () => {
        counter--;
        updateCounter();
    });

    resetBtn.addEventListener('click', () => {
        counter = 0;
        updateCounter();
    });

    // Clock functionality
    function updateClock() {
        const now = new Date();
        const timeString = now.toLocaleTimeString();
        const dateString = now.toLocaleDateString();
        document.getElementById('clock').innerHTML = `${timeString}<br><small>${dateString}</small>`;
    }

    // Update clock every second
    setInterval(updateClock, 1000);
    updateClock(); // Initial call

    // Random quotes
    const quotes = [
        "The only way to do great work is to love what you do. - Steve Jobs",
        "Life is what happens to you while you're busy making other plans. - John Lennon",
        "The future belongs to those who believe in the beauty of their dreams. - Eleanor Roosevelt",
        "It is during our darkest moments that we must focus to see the light. - Aristotle",
        "Success is not final, failure is not fatal: it is the courage to continue that counts. - Winston Churchill",
        "The only impossible journey is the one you never begin. - Tony Robbins",
        "In the end, we will remember not the words of our enemies, but the silence of our friends. - Martin Luther King Jr.",
        "Be yourself; everyone else is already taken. - Oscar Wilde"
    ];

    const quoteElement = document.getElementById('quote');
    const quoteBtn = document.getElementById('quote-btn');

    quoteBtn.addEventListener('click', () => {
        const randomIndex = Math.floor(Math.random() * quotes.length);
        quoteElement.textContent = quotes[randomIndex];
        
        // Add animation effect
        quoteElement.style.opacity = '0';
        setTimeout(() => {
            quoteElement.style.opacity = '1';
        }, 100);
    });

    // Add some interactive effects
    document.querySelectorAll('.card').forEach(card => {
        card.addEventListener('mouseenter', () => {
            card.style.background = '#e3f2fd';
        });
        
        card.addEventListener('mouseleave', () => {
            card.style.background = '#f8f9fa';
        });
    });

    // Console message for developers
    console.log('🚀 S3 Website Test - JavaScript is working!');
    console.log('This website is hosted on Amazon S3 and deployed with Terraform.');