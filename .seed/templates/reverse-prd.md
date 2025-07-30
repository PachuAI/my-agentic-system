# Reverse-Engineered PRD - [PROJECT NAME]

*Generated from existing codebase analysis*  
*Date: [DATE]*  
*Stack: [DETECTED_STACK]*  
*Original Analysis: project-analysis.md v[VERSION]*

---

## Product Overview

### Project Description
**What This Application Does**: [High-level description inferred from code structure and functionality]

**Primary Purpose**: [Main business objective based on implemented features]

**Target Users**: [User types identified from UI patterns, authentication, and features]

### Business Context
- **Industry/Domain**: [Inferred from business logic and data models]
- **Business Model**: [E-commerce/SaaS/Content/etc. based on features]
- **Revenue Model**: [Subscription/One-time/Freemium/etc. if identifiable]
- **Market Position**: [B2B/B2C/Internal Tool based on complexity and features]

---

## User Stories (Extracted from Code)

### Core Features Implemented
1. **[Feature Name]**
   - **As a** [User Type]
   - **I want to** [Action/Goal inferred from code]
   - **So that** [Benefit/Value inferred from business logic]
   - **Implementation**: [Brief technical summary]
   - **Completeness**: [Fully/Partially implemented]

2. **[Feature Name]**
   - **As a** [User Type]
   - **I want to** [Action/Goal inferred from code]
   - **So that** [Benefit/Value inferred from business logic]
   - **Implementation**: [Brief technical summary]
   - **Completeness**: [Fully/Partially implemented]

3. **[Feature Name]**
   - **As a** [User Type]
   - **I want to** [Action/Goal inferred from code]
   - **So that** [Benefit/Value inferred from business logic]
   - **Implementation**: [Brief technical summary]
   - **Completeness**: [Fully/Partially implemented]

### User Flows Identified
1. **[Primary User Flow]**
   - Entry point: [Where users start]
   - Key steps: [Main interaction sequence]
   - Exit point: [Where flow completes]
   - Success criteria: [What constitutes completion]

2. **[Secondary User Flow]**
   - Entry point: [Where users start]
   - Key steps: [Main interaction sequence]
   - Exit point: [Where flow completes]
   - Success criteria: [What constitutes completion]

### Admin/Management Features
- **[Admin Feature]**: [Description and purpose]
- **[Admin Feature]**: [Description and purpose]
- **[Admin Feature]**: [Description and purpose]

---

## Functional Requirements (Inferred)

### Authentication & Authorization
- **User Types**: [Roles identified from code]
  - [Role 1]: [Permissions and capabilities]
  - [Role 2]: [Permissions and capabilities]
- **Authentication Method**: [Session/JWT/OAuth/etc.]
- **Password Requirements**: [If identifiable from validation]
- **Session Management**: [Timeout, persistence, etc.]

### Data Management
- **Core Entities**: [Main data models identified]
  - **[Entity]**: [Fields, relationships, purpose]
  - **[Entity]**: [Fields, relationships, purpose]
  - **[Entity]**: [Fields, relationships, purpose]

- **Data Relationships**: [Key relationships between entities]
- **Data Validation**: [Validation rules found in code]
- **Data Storage**: [Database type, file storage, etc.]

### Business Logic
- **Core Workflows**: [Main business processes implemented]
  1. **[Workflow]**: [Steps and business rules]
  2. **[Workflow]**: [Steps and business rules]

- **Calculation Logic**: [Pricing, scoring, metrics, etc.]
- **Notification System**: [Email, SMS, in-app notifications]
- **Reporting Features**: [Analytics, exports, dashboards]

### Integration Requirements
- **External APIs**: [Third-party services integrated]
  - **[Service]**: [Purpose and implementation details]
  - **[Service]**: [Purpose and implementation details]

- **Payment Processing**: [Stripe, PayPal, etc. if present]
- **File Upload/Storage**: [Local, S3, CDN, etc.]
- **Email System**: [SMTP, SendGrid, etc.]

---

## Non-Functional Requirements (Inferred)

### Performance Requirements
- **Expected Load**: [Based on architecture and optimization choices]
- **Response Time**: [Based on caching and optimization implemented]
- **Concurrency**: [Based on async patterns and database design]
- **Data Volume**: [Based on database schema and indexing]

### Security Requirements
- **Data Protection**: [Encryption, hashing patterns found]
- **Input Validation**: [XSS, SQL injection protection implemented]
- **Authentication Security**: [2FA, password policies, etc.]
- **Authorization Controls**: [RBAC, permissions implementation]
- **Audit Requirements**: [Logging patterns identified]

### Scalability Requirements
- **Horizontal Scaling**: [Load balancer ready, stateless design]
- **Database Scaling**: [Read replicas, sharding patterns]
- **Caching Strategy**: [Redis, Memcached, application cache]
- **CDN Requirements**: [Static asset handling]

### Reliability Requirements
- **Uptime Target**: [Based on error handling and monitoring]
- **Backup Strategy**: [Database backups, file backups]
- **Disaster Recovery**: [Failover mechanisms implemented]
- **Error Handling**: [Error reporting, user-friendly messages]

---

## Technical Constraints (Current)

### Technology Stack
- **Backend**: [Framework and version]
- **Frontend**: [Framework and version]
- **Database**: [Type and version]
- **Cache**: [Redis/Memcached if present]
- **Queue System**: [Background job processing]

### Development Constraints
- **Team Size**: [Inferred from git history]
- **Development Timeline**: [Inferred from commit patterns]
- **Budget Constraints**: [Inferred from technology choices]
- **Skill Requirements**: [Based on complexity and patterns used]

### Deployment Constraints
- **Hosting Environment**: [Cloud/Self-hosted/Shared hosting]
- **CI/CD Pipeline**: [Present/Missing]
- **Environment Management**: [Dev/Staging/Production setup]
- **Monitoring**: [Application monitoring implemented]

---

## User Interface Requirements

### Design Patterns
- **UI Framework**: [Bootstrap, Tailwind, Custom CSS]
- **Design System**: [Consistent patterns identified]
- **Responsive Design**: [Mobile-first, adaptive, fixed-width]
- **Accessibility**: [ARIA labels, keyboard navigation, etc.]

### User Experience
- **Navigation Pattern**: [Menu structure, breadcrumbs, etc.]
- **Form Design**: [Validation, error handling, UX patterns]
- **Feedback System**: [Success messages, loading states, etc.]
- **Help System**: [Documentation, tooltips, tutorials]

### Browser Support
- **Target Browsers**: [Based on JS/CSS compatibility]
- **Mobile Support**: [Responsive design, mobile-first]
- **Offline Capabilities**: [Service workers, local storage]

---

## Data Requirements

### Data Models (Identified)
```
[Entity Relationship Diagram based on code analysis]

User
├── id, email, password_hash
├── profile (name, avatar, preferences)
└── relationships: [has_many orders, belongs_to role]

[Additional entities with their fields and relationships]
```

### Data Sources
- **Primary Database**: [Type and key tables]
- **External Data**: [APIs, imports, feeds]
- **File Storage**: [Images, documents, uploads]
- **Analytics Data**: [Tracking, metrics, logs]

### Data Flow
1. **Input**: [How data enters the system]
2. **Processing**: [How data is transformed]
3. **Storage**: [How data is persisted]
4. **Output**: [How data is presented/exported]

---

## Integration Requirements

### Current Integrations
- **[Service Name]**: 
  - **Purpose**: [What it's used for]
  - **Implementation**: [How it's integrated]
  - **Dependencies**: [Critical/Nice-to-have]

### Missing Integrations (Potential)
- **[Suggested Service]**: [Why it might be needed]
- **[Suggested Service]**: [Why it might be needed]

---

## Compliance Requirements (If Applicable)

### Data Privacy
- **GDPR Compliance**: [Data handling patterns observed]
- **CCPA Compliance**: [Privacy controls implemented]
- **Data Retention**: [Deletion patterns, archiving]

### Industry Standards
- **[Standard Name]**: [Compliance level based on implementation]
- **[Standard Name]**: [Compliance level based on implementation]

---

## Success Metrics (Inferred)

### Business Metrics
- **User Engagement**: [Based on features that track usage]
- **Conversion Rates**: [Based on funnel implementation]
- **Revenue Metrics**: [Based on payment/billing features]

### Technical Metrics
- **Performance**: [Page load, API response times]
- **Reliability**: [Uptime, error rates]
- **Security**: [Vulnerability scans, audit logs]

---

## Assumptions & Unknowns

### Assumptions Made
1. **[Assumption]**: [Why this was assumed based on code evidence]
2. **[Assumption]**: [Why this was assumed based on code evidence]
3. **[Assumption]**: [Why this was assumed based on code evidence]

### Information Gaps
1. **[Unknown]**: [What's missing and why it's important]
2. **[Unknown]**: [What's missing and why it's important]
3. **[Unknown]**: [What's missing and why it's important]

### Validation Needed
- [ ] **Business requirements**: Confirm with stakeholders
- [ ] **User personas**: Validate target user assumptions
- [ ] **Feature priorities**: Understand business importance
- [ ] **Technical constraints**: Confirm infrastructure limitations
- [ ] **Compliance needs**: Verify regulatory requirements

---

## Next Steps for PRD Validation

### 1. Stakeholder Interviews
- **Business Owner**: Validate business objectives and priorities
- **End Users**: Confirm user needs and pain points
- **Technical Lead**: Review technical constraints and decisions

### 2. Requirements Refinement
- **Missing Features**: Identify gaps between code and business needs
- **Priority Adjustment**: Align development priorities with business value
- **Scope Clarification**: Define what's in/out of scope

### 3. Documentation Completion
- **User Stories**: Expand and refine user stories
- **Acceptance Criteria**: Define clear success criteria
- **Technical Specs**: Document API contracts and data schemas

---

## Confidence Levels

### High Confidence (90%+)
- **Core functionality**: [Features clearly implemented and testable]
- **Data models**: [Database schema is explicit]
- **User flows**: [UI and logic clearly define user journeys]

### Medium Confidence (70-90%)
- **Business requirements**: [Inferred from implementation patterns]
- **Performance requirements**: [Based on architecture choices]
- **Integration needs**: [Based on current integrations]

### Low Confidence (50-70%)
- **Business objectives**: [Require stakeholder validation]
- **User personas**: [Assumed from UI patterns]
- **Future requirements**: [Not evident in current code]

---

*This reverse-engineered PRD should be validated with business stakeholders and refined based on actual business requirements. Use it as a starting point for product planning and development prioritization.*

*Generated by Agentic Seed Rescue Mode - Review improvement plan for recommended next steps.*