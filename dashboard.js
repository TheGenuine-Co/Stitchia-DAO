(function () {
  function formatEth(value) {
    return typeof value === 'number' ? value.toLocaleString(undefined, { maximumFractionDigits: 2 }) : '—';
  }

  function renderLegend(roles, counts) {
    const legend = document.getElementById('rolesLegend');
    if (!legend || !Array.isArray(roles)) return;
    legend.textContent = '';
    roles.forEach((role) => {
      const li = document.createElement('li');
      const dot = document.createElement('span');
      dot.className = `dot ${role.toLowerCase()}`;
      dot.setAttribute('aria-hidden', 'true');
      li.appendChild(dot);
      li.appendChild(document.createTextNode(role));
      if (counts && typeof counts[role] === 'number') {
        const count = document.createElement('span');
        count.className = 'count';
        count.textContent = ` ${counts[role]}`;
        li.appendChild(count);
      }
      legend.appendChild(li);
    });
  }

  fetch('../data.json')
    .then((resp) => resp.json())
    .then((data) => {
      const governance = data.governance || {};
      const members = governance.members_total;
      if (typeof members === 'number') {
        const metric = document.getElementById('membersMetric');
        if (metric) metric.textContent = `${members} Spiral Members`;
      }
      renderLegend(governance.roles, governance.counts);

      const treasury = data.treasury || {};
      const total = document.getElementById('treasuryValue');
      const sub = document.getElementById('treasurySub');
      if (total) total.innerHTML = `<strong>${formatEth(treasury.total_eth)} ETH</strong>`;
      if (sub) {
        const staking = formatEth(treasury.staking_eth);
        const protocol = formatEth(treasury.protocol_eth);
        const updated = treasury.updated_at ? new Date(treasury.updated_at).toLocaleDateString() : '—';
        sub.textContent = `${staking} ETH Staking • ${protocol} ETH Protocol • Updated ${updated}`;
      }

      const proposals = (data.proposals && Array.isArray(data.proposals.items)) ? data.proposals.items : [];
      const list = document.getElementById('proposalsList');
      if (list) {
        list.textContent = '';
        proposals.forEach((proposal) => {
          const li = document.createElement('li');
          const title = document.createElement('strong');
          title.textContent = proposal.title;
          const meta = document.createElement('span');
          meta.textContent = `${proposal.status} (${proposal.age_days}d)`;
          li.appendChild(title);
          li.appendChild(meta);
          list.appendChild(li);
        });
      }
    })
    .catch(() => {
      // omit errors in static preview
    });
})();
