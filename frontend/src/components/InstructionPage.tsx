import React from 'react';
import styled from 'styled-components';

const Container = styled.div`
  max-width: 800px;
  margin: 40px auto;
  padding: 20px;
  color: #fff;
  background-color: #121212;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
  font-family: "Arial", sans-serif;
`;

const Title = styled.h1`
  font-size: 32px;
  margin-bottom: 20px;
  text-align: center;
  color: #4caf50;
`;

const Section = styled.section`
  margin-bottom: 30px;
`;

const SectionTitle = styled.h2`
  font-size: 24px;
  margin-bottom: 10px;
  color: #ff9800;
`;

const Paragraph = styled.p`
  font-size: 16px;
  line-height: 1.6;
`;

const InstructionList = styled.ul`
  list-style: disc;
  margin-left: 20px;
  font-size: 16px;
  line-height: 1.6;
`;

const InstructionPage: React.FC = () => {
  return (
    <Container>
      <Title>CapsuleCore Protocol Interaction Instructions</Title>

      <Section>
        <SectionTitle>Introduction</SectionTitle>
        <Paragraph>
          CapsuleCore provides a decentralized framework for capsule management, governance, and staking. This guide will walk you through the process of managing capsules, interacting with the governance system, and staking tokens. You’ll also learn how to claim and create capsules, update claim fees, and manage roles within the system.
        </Paragraph>
      </Section>

      <Section>
        <SectionTitle>1️⃣ Registering a Capsule</SectionTitle>
        <InstructionList>
          <li>Open the <strong>Capsule Registration</strong> panel.</li>
          <li>Provide your <code>_dataURI</code> with capsule-specific metadata.</li>
          <li>Click <strong>Create Capsule</strong> to deploy your new capsule to the system.</li>
        </InstructionList>
      </Section>

      <Section>
        <SectionTitle>2️⃣ Claiming a Capsule</SectionTitle>
        <InstructionList>
          <li>Navigate to the <strong>Claim Capsule</strong> section.</li>
          <li>Enter the <code>capsuleId</code> of the capsule you wish to claim.</li>
          <li>Click <strong>Claim</strong> to finalize your capsule claim.</li>
        </InstructionList>
      </Section>

      <Section>
        <SectionTitle>3️⃣ Setting Claim Fees</SectionTitle>
        <InstructionList>
          <li>Go to the <strong>Admin Settings</strong> panel.</li>
          <li>Input the new claim fee as a <code>uint256</code> value.</li>
          <li>Click <strong>Set Fee</strong> to adjust the fee required for capsule claims.</li>
        </InstructionList>
      </Section>

      <Section>
        <SectionTitle>4️⃣ Managing Ownership</SectionTitle>
        <InstructionList>
          <li>To transfer ownership of the CapsuleCore system, navigate to the <strong>Ownership</strong> section.</li>
          <li>Enter the new owner's <code>address</code> and click <strong>Transfer Ownership</strong>.</li>
          <li>Alternatively, use <strong>Renounce Ownership</strong> to relinquish control of the system.</li>
        </InstructionList>
      </Section>

      <Section>
        <SectionTitle>5️⃣ Managing Governance</SectionTitle>
        <InstructionList>
          <li>Visit the <strong>Governance</strong> section to review or manage active proposals.</li>
          <li>Check the <code>activeProposals</code> and <code>completedProposals</code> to track proposal status.</li>
          <li>Set the <code>proposalThreshold</code> to define the minimum conditions for creating proposals.</li>
        </InstructionList>
      </Section>

      <Section>
        <SectionTitle>6️⃣ Managing Deposits</SectionTitle>
        <InstructionList>
          <li>Check if deposits are paused by using <code>isDepositPaused</code>.</li>
          <li>If not paused, you can make deposits to the system as required.</li>
          <li>Ensure you adhere to the <code>MIN_DEPOSIT_AMOUNT</code> and <code>MAX_DEPOSIT_AMOUNT</code> limits.</li>
        </InstructionList>
      </Section>

      <Section>
        <SectionTitle>7️⃣ Staking Tokens</SectionTitle>
        <InstructionList>
          <li>Navigate to the <strong>Staking</strong> panel.</li>
          <li>Stake the required <code>stakeToken</code> to participate in governance and voting.</li>
          <li>Ensure you have the minimum staking amount defined by <code>minVotingPower</code>.</li>
        </InstructionList>
      </Section>

      <Section>
        <SectionTitle>8️⃣ Managing Voting</SectionTitle>
        <InstructionList>
          <li>Ensure voting is not paused by checking <code>isVotingPaused</code>.</li>
          <li>Participate in voting by using the <code>votingToken</code> and voting on active proposals.</li>
          <li>Verify your voting power by using the <code>maxVotingPower</code> and <code>minVotingPower</code> limits.</li>
        </InstructionList>
      </Section>

      <Section>
        <SectionTitle>9️⃣ Handling System Pauses</SectionTitle>
        <InstructionList>
          <li>Check whether the system is paused using <code>isSystemPaused</code>.</li>
          <li>If paused, follow the instructions for system maintenance or recovery.</li>
        </InstructionList>
      </Section>

      <Section>
        <SectionTitle>🔐 Managing Roles and Permissions</SectionTitle>
        <InstructionList>
          <li>In the <strong>Roles and Permissions</strong> section, use <code>grantRole</code> or <code>revokeRole</code> to manage user roles.</li>
          <li>Check existing roles with <code>hasRole</code> to ensure correct permissions.</li>
        </InstructionList>
      </Section>

      <Section>
        <SectionTitle>📊 Viewing Capsule Statistics</SectionTitle>
        <InstructionList>
          <li>Check the overall system statistics including <code>totalDeposits</code> and <code>votingPeriod</code>.</li>
          <li>Review the <code>capsuleCounter</code> to see how many capsules are in the system.</li>
          <li>Monitor your <code>capsuleId</code> and <code>rewardToken</code> status for personal updates.</li>
        </InstructionList>
      </Section>

      <Section>
        <SectionTitle>📞 Need Help?</SectionTitle>
        <InstructionList>
          <li>Ensure your capsule is properly registered and linked to your account.</li>
          <li>For any issues with governance or capsule management, contact our support team or refer to the docs.</li>
          <li>Join our Discord or Telegram channels for real-time support and updates.</li>
        </InstructionList>
      </Section>
    </Container>
  );
};

export default InstructionPage;