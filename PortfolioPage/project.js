// Search form submit event listener
document.getElementById('searchForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevent form submission

    const query = document.getElementById('searchInput').value.toLowerCase(); // Get the search query and convert to lowercase
    const bodyText = document.body.innerText.toLowerCase(); // Get the text content of the entire page

    // Clear previous results
    const searchResultsContainer = document.getElementById('searchResults');
    searchResultsContainer.innerHTML = ''; // Clear previous results

    if (query) {
        // Initialize variables for storing results
        let searchResultCount = 0;
        let resultIndices = [];

        // Use regex to find all occurrences of the search query
        const regex = new RegExp(query, 'gi');
        const matches = [...document.body.innerText.matchAll(regex)];

        if (matches.length > 0) {
            searchResultCount = matches.length;

            // Loop through each match and highlight
            matches.forEach((match, index) => {
                const matchText = match[0];
                const resultIndex = bodyText.indexOf(matchText.toLowerCase(), resultIndices.length > 0 ? resultIndices[resultIndices.length - 1] + 1 : 0);
                resultIndices.push(resultIndex);

                // Add each result as a clickable link in the searchResults div
                const resultItem = document.createElement('div');
                resultItem.className = 'result-item';
                resultItem.innerHTML = `<a href="#result${index}" onclick="scrollToResult(${index});">${index + 1}: ${matchText}</a>`;
                searchResultsContainer.appendChild(resultItem);

                // Wrap the result with a span that will be scrolled to
                document.body.innerHTML = document.body.innerHTML.replace(matchText, `<span id="result${index}" class="highlighted">${matchText}</span>`);
            });

            // Display total results
            const totalResults = document.createElement('div');
            totalResults.className = 'total-results';
            totalResults.innerText = `Total results: ${searchResultCount}`;
            searchResultsContainer.appendChild(totalResults);

            // Show dropdown results with opacity
            searchResultsContainer.style.display = 'block';
        } else {
            // No results found
            alert('No results found.');
            searchResultsContainer.style.display = 'none'; // Hide the results if no match is found
        }
    }
});

// Function to scroll to a specific result by its index
function scrollToResult(index) {
    const resultElement = document.getElementById(`result${index}`);
    if (resultElement) {
        resultElement.scrollIntoView({ behavior: 'smooth' });
        resultElement.style.backgroundColor = "yellow"; // Highlight the result
    }
}

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
        parallax.style.backgroundPositionY = `${scrolled * 0.5}px`;
    });
});

// Function to play video when clicked
function playVideo(event, videoSrc) {
    event.preventDefault(); // Prevent any default link behavior
    const videoElement = document.getElementById("main_video");
    videoElement.src = videoSrc;
    videoElement.play();
  }
// Function to toggle hamburger menu on small screens
document.querySelector(".hamburger-menu").addEventListener("click", function () {
    const navLinks = document.querySelector(".nav-links");
    navLinks.style.display = navLinks.style.display === "flex" ? "none" : "flex";
  });
