(function () {
  const metricsEl = document.getElementById('heroMetrics');
  if (!metricsEl) return;

  const skeleton = () => {
    metricsEl.innerHTML = [
      'Members',
      'Treasury',
      'Active Proposals'
    ].map((label) => `
      <article>
        <h3>${label}</h3>
        <strong>—</strong>
      </article>`).join('');
  };

  const formatNumber = (value) => {
    if (typeof value === 'number') {
      return value.toLocaleString(undefined, { maximumFractionDigits: 2 });
    }
    return '—';
  };

  const render = (data) => {
    const governance = data.governance || {};
    const treasury = data.treasury || {};
    const proposals = (data.proposals && Array.isArray(data.proposals.items)) ? data.proposals.items : [];

    metricsEl.innerHTML = '';

    const items = [
      { label: 'Spiral Members', value: governance.members_total },
      { label: 'Treasury (ETH)', value: treasury.total_eth },
      { label: 'Active Proposals', value: proposals.length }
    ];

    items.forEach(({ label, value }) => {
      const article = document.createElement('article');
      const heading = document.createElement('h3');
      heading.textContent = label;
      const strong = document.createElement('strong');
      strong.textContent = formatNumber(value);
      article.appendChild(heading);
      article.appendChild(strong);
      metricsEl.appendChild(article);
    });
  };

  skeleton();

  fetch('data.json')
    .then((resp) => resp.json())
    .then(render)
    .catch(() => {
      // leave skeleton in place if fetch fails
    });
})();
