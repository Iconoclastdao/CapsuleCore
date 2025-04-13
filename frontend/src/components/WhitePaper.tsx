import React from 'react';
import styled from 'styled-components';

const Container = styled.div`
  font-family: "Bradley DJR Variable", sans-serif;
  background-image: url('/logo1.jpeg');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  background-attachment: fixed;
  color: orange;
  text-shadow: 2px 2px 4px black;
  width: 100%;
  max-width: 900px;
  margin: 24px auto;
  padding: var(--padding);
  border-radius: var(--border-radius);
  box-shadow: var(--shadow);
`;

const Title = styled.h1`
  text-align: center;
  font-size: 2.2rem;
  margin-bottom: 2rem;
`;

const Section = styled.section`
  margin-bottom: 2rem;
`;

const SectionTitle = styled.h2`
  font-size: 1.6rem;
  margin-bottom: 1rem;
`;

const Paragraph = styled.p`
  font-size: 2rem;
  margin-bottom: 1rem;
  line-height: 1.5;
`;

const List = styled.ul`
  margin-left: 1.5rem;
  margin-bottom: 1rem;
  list-style: disc;

  li {
    margin-bottom: 0.5rem;
  }
`;

const WhitePaper: React.FC = () => {
  return (
    <Container>
      <Title>CapsuleCore: Modular Smart Contract Architecture for DeFi Protocols and AI Agents</Title>

      <Section>
        <SectionTitle>Abstract</SectionTitle>
        <Paragraph>
          The <strong>CapsuleCore</strong> framework introduces a modular smart contract architecture that enables developers to
          create decentralized applications (dApps) with composable, reusable components. In addition to its core capabilities for DeFi protocols, CapsuleCore expands its versatility by integrating AI agents, which can perform autonomous tasks, process complex data, and contribute to the decentralized ecosystem.
        </Paragraph>
        <Paragraph>
          This paper explores the architecture, key features, use cases, and governance of CapsuleCore with AI agents. CapsuleCore provides a new paradigm for decentralized applications that are intelligent, scalable, and highly customizable.
        </Paragraph>
      </Section>

      <Section>
        <SectionTitle>1. Introduction</SectionTitle>
        <Paragraph>
          Traditional smart contract architectures often face challenges like contract size limits, inflexibility in contract
          logic, and inefficient testing. CapsuleCore addresses these challenges by adopting a modular approach, breaking down
          functionality into composable "Capsules" (components). In addition to its core DeFi functionality, CapsuleCore introduces
          AI agent capsules, which enhance the ecosystem by enabling autonomous decision-making, data analysis, and more.
        </Paragraph>
        <List>
          <li>Modular design with reusable components for DeFi and AI applications.</li>
          <li>Bypasses Solidity’s contract size limit.</li>
          <li>Independent testing and upgradeability of contract components.</li>
          <li>AI agent capsules that autonomously execute tasks, analyze data, and optimize processes.</li>
        </List>
      </Section>

      <Section>
        <SectionTitle>2. Architecture</SectionTitle>

        <SectionTitle>2.1 Capsule-Linked AI Components</SectionTitle>
        <Paragraph>
          CapsuleCore consists of base contracts, each performing specific functions like event handling, state storage, task management, and now AI tasks. These AI-driven capsules can analyze off-chain data, execute machine learning models, and perform autonomous decision-making processes.
        </Paragraph>

        <SectionTitle>2.2 AI Task and State Management</SectionTitle>
        <Paragraph>
          Capsules interact via clearly defined interfaces. AI agent capsules are assigned tasks based on data-driven decisions, allowing them to predict, analyze, and respond to real-time information. These capsules can update their behavior through learning and data feedback.
        </Paragraph>

        <SectionTitle>2.3 AI-Powered Swarm Execution</SectionTitle>
        <Paragraph>
          AI agents operate in swarms, where multiple instances of the same agent collaborate to achieve tasks. This swarm execution allows AI agents to perform decentralized, parallel data analysis, optimizing the results by pooling data and leveraging consensus.
        </Paragraph>
      </Section>

      <Section>
        <SectionTitle>3. Capsule Lifecycle</SectionTitle>
        <List>
          <li><strong>Registration:</strong> AI agents are registered in the system with a unique ID, staking mechanism, and AI capabilities.</li>
          <li><strong>Task Execution:</strong> AI agents analyze data, trigger off-chain events, process tasks, and submit results.</li>
          <li><strong>Consensus:</strong> Matching responses from multiple AI agents are validated and posted on-chain to form a consensus.</li>
          <li><strong>Reward/Slash:</strong> AI agents are rewarded or slashed based on the accuracy of their results and participation in consensus.</li>
        </List>
      </Section>

      <Section>
        <SectionTitle>4. Use Cases</SectionTitle>
        <List>
          <li>Cross-chain price feeds and market analysis for DeFi protocols powered by AI agents.</li>
          <li>Custom AI-driven oracles for decentralized platforms that process complex data or make predictions.</li>
          <li>Autonomous event-driven dApp functionality, powered by AI agents that trigger actions based on external inputs.</li>
          <li>AI-powered oracle extensions for advanced use cases, such as IoT data analysis, AI-driven financial modeling, or predictive market insights.</li>
        </List>
      </Section>

      <Section>
        <SectionTitle>5. Security & Integrity</SectionTitle>
        <Paragraph>
          CapsuleCore emphasizes data integrity and trust. Each AI agent capsule signs its outputs, ensuring authenticity. Results from multiple AI agents are validated through consensus, and slashing is enforced for malicious or faulty behavior.
        </Paragraph>
        <List>
          <li>AI agents are subject to the same slashing and reward systems as other capsules to maintain trust.</li>
          <li>AI agents’ behavior and results are tracked on-chain to build a reputation system.</li>
          <li>Future ZK-based verification will enhance privacy for AI agents’ task execution.</li>
        </List>
      </Section>

      <Section>
        <SectionTitle>6. Governance & Modularity</SectionTitle>
        <Paragraph>
          CapsuleCore is governed by a decentralized authority, where DAOs or governance mechanisms control task priorities,
          reward distribution, and upgrades for both traditional and AI agent capsules. AI agents may also propose governance changes based on learned data.
        </Paragraph>
      </Section>

      <Section>
        <SectionTitle>7. Roadmap</SectionTitle>
        <List>
          <li><strong>Phase 1:</strong> Capsule registration and staking, with basic functionality and task execution.</li>
          <li><strong>Phase 2:</strong> AI agent registration and deployment, with machine learning model integration and autonomous decision-making.</li>
          <li><strong>Phase 3:</strong> AI-powered decentralized applications, enhanced by Zero-Knowledge Proofs (ZKPs) and autonomous agent clusters.</li>
        </List>
      </Section>
    </Container>
  );
}

export default WhitePaper;