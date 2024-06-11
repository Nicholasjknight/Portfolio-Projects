document.getElementById('searchForm').addEventListener('submit', function(event) {
    event.preventDefault();
    const query = document.getElementById('searchInput').value;
    if (query) {
        alert(`Searching for: ${query}`);
    } else {
        alert('Please enter a search term.');
    }
});

document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
        e.preventDefault();
        document.querySelector(this.getAttribute('href')).scrollIntoView({
            behavior: 'smooth'
        });
    });
});

function scrollToTop() {
    window.scrollTo(0, 0);
}

window.addEventListener('scroll', function() {
    const scrolled = window.scrollY;
    const rotatingBackground = document.querySelector('.rotating-background');
    const currentRotation = parseFloat(rotatingBackground.style.transform.match(/rotate\((-?\d+\.?\d*)deg\)/)[1]);
    const currentScale = parseFloat(rotatingBackground.style.transform.match(/scale\((-?\d+\.?\d*)\)/)[1]);

    if (currentRotation >= 350.6 && currentScale >= 2.753) {
        rotatingBackground.style.animation = 'none';
    } else {
        rotatingBackground.style.animation = 'spinZoom 20s linear infinite';
    }

    rotatingBackground.style.transform = `scale(${1 + scrolled / 1000}) rotate(${scrolled / 5}deg)`;

    document.querySelectorAll('.parallax').forEach(parallax => {
        const speed = parallax.getAttribute('data-speed');
        const yPos = -(scrolled * speed);
        parallax.style.transform = `translateY(${yPos}px)`;
    });
});

function playVideo(event, videoSrc) {
    event.preventDefault();
    var mainVideo = document.getElementById('main_video');
    mainVideo.src = videoSrc;
    mainVideo.play();
}
