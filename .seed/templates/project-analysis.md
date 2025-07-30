# Project Analysis - [PROJECT NAME]

*Analysis Date: [DATE]*  
*Stack Detected: [STACK]*  
*Analysis Type: Rescue Mode*

## Executive Summary

### Project Overview
- **Primary Technology**: [Laravel/Next.js/React/Python]
- **Project Type**: [Web App/API/SPA/Full-Stack]
- **Development Stage**: [MVP/Production/Legacy/Abandoned]
- **Last Activity**: [Date of last significant commit]
- **Team Size**: [Number] developers (based on git history)

### Health Score: [X]/10
- **Code Quality**: [X]/10 - [Brief assessment]
- **Security**: [X]/10 - [Security posture] 
- **Performance**: [X]/10 - [Performance assessment]
- **Maintainability**: [X]/10 - [How maintainable]
- **Documentation**: [X]/10 - [Documentation level]

### Key Findings
- ✅ **Strengths**: [2-3 main strengths]
- ⚠️ **Areas for Improvement**: [2-3 main issues]  
- 🚨 **Critical Issues**: [Any show-stoppers]

---

## Codebase Analysis

### Structure Overview
```
[Project structure - key directories and files]
project-root/
├── [main directories with file counts]
├── [configuration files]
└── [documentation files]
```

### Metrics
| Metric | Value | Assessment |
|--------|-------|------------|
| **Total Files** | [X] files | [Normal/High/Low for project type] |
| **Lines of Code** | [X] LOC | [Assessment] |
| **Test Files** | [X] files | [Coverage assessment] |
| **Dependencies** | [X] total ([X] outdated) | [Health status] |
| **Git Commits** | [X] commits | [Activity level] |
| **Contributors** | [X] people | [Team size indicator] |

### Technology Stack Details
- **[Stack] Version**: [Version] ([Current/Outdated] - Current: [Latest])
- **Key Dependencies**:
  - [Dependency 1]: [Version] ([Status])
  - [Dependency 2]: [Version] ([Status])
  - [Dependency 3]: [Version] ([Status])
- **Development Tools**: [Linters, formatters, build tools]
- **Testing Framework**: [Framework] ([Coverage]% coverage)

---

## Architecture Assessment

### Current Architecture Pattern
**Pattern**: [Monolithic/Microservices/Layered/MVC/Component-based]

**Description**: [How the application is structured]

### Architecture Diagram
```
[Text-based architecture diagram]
┌─────────────────┐    ┌─────────────────┐
│   Frontend      │◄──►│    Backend      │
│   [Framework]   │    │   [Framework]   │
└─────────────────┘    └─────────────────┘
         │                       │
         ▼                       ▼
┌─────────────────┐    ┌─────────────────┐
│   Static Files  │    │   Database      │
│   [Location]    │    │   [Type]        │
└─────────────────┘    └─────────────────┘
```

### Data Flow
1. **User Interaction**: [How users interact]
2. **Request Processing**: [How requests are handled]  
3. **Data Access**: [How data is accessed/stored]
4. **Response Generation**: [How responses are created]

### API Design (if applicable)
- **Style**: [REST/GraphQL/RPC]
- **Endpoints**: [X] endpoints identified
- **Authentication**: [Method used]
- **Documentation**: [Available/Missing]

---

## Stack-Specific Analysis

### [Laravel/Next.js/React/Python] Specific Findings

#### Code Organization
- **[Framework-specific structure]**: [Assessment]
- **Follows Conventions**: [Yes/Partially/No] - [Details]
- **Best Practices**: [Which ones are followed/missing]

#### Framework Features Usage
- **[Feature 1]**: [Used/Not Used] - [Assessment if used]
- **[Feature 2]**: [Used/Not Used] - [Assessment if used]
- **[Feature 3]**: [Used/Not Used] - [Assessment if used]

#### Performance Considerations
- **[Stack-specific optimization]**: [Implemented/Missing]
- **Caching Strategy**: [Present/Absent] - [Details]
- **Database Optimization**: [Query optimization status]

---

## Quality Assessment

### Code Quality Metrics
- **Complexity**: [Average/High complexity areas identified]
- **Code Duplication**: [Level of duplication found]
- **Naming Conventions**: [Consistent/Inconsistent]
- **Function/Method Size**: [Generally appropriate/Some large methods]

### Testing Analysis
- **Test Coverage**: [X]% ([Excellent/Good/Poor])
- **Test Types**:
  - Unit Tests: [X] tests ([Assessment])
  - Integration Tests: [X] tests ([Assessment])
  - E2E Tests: [Present/Missing]
- **Test Quality**: [Well-written/Basic/Needs improvement]

### Dependencies Health
- **Outdated Dependencies**: [X] of [Y] need updates
- **Security Vulnerabilities**: [X] found ([High/Medium/Low] severity)
- **Unused Dependencies**: [X] potentially unused
- **License Compatibility**: [All compatible/Issues found]

---

## Security Analysis

### Security Posture: [Strong/Moderate/Weak]

#### Authentication & Authorization
- **Authentication Method**: [JWT/Session/OAuth/etc.]
- **Authorization Implementation**: [RBAC/Simple/None]
- **Session Management**: [Secure/Needs improvement]

#### Data Protection
- **Sensitive Data Handling**: [Properly encrypted/Exposed]
- **Input Validation**: [Comprehensive/Basic/Missing]
- **Output Encoding**: [Implemented/Missing]
- **SQL Injection Protection**: [Protected/Vulnerable]

#### Infrastructure Security
- **Environment Variables**: [Properly secured/Exposed]
- **HTTPS Implementation**: [Enforced/Optional/Missing]
- **Security Headers**: [Implemented/Missing]
- **CORS Configuration**: [Appropriate/Overly permissive]

#### Vulnerabilities Found
1. **[Vulnerability Type]**: [Description and impact]
2. **[Vulnerability Type]**: [Description and impact]

---

## Performance Analysis

### Current Performance Profile
- **Page Load Times**: [Fast/Moderate/Slow] (estimated)
- **Bundle Sizes**: [Frontend - size if applicable]
- **Database Queries**: [Optimized/Some N+1/Many issues]
- **Caching**: [Comprehensive/Basic/None]

### Bottlenecks Identified
1. **[Bottleneck Area]**: [Description and impact]
2. **[Bottleneck Area]**: [Description and impact]

### Optimization Opportunities
- **Quick Wins**: [Easy optimizations with high impact]
- **Medium Effort**: [Moderate changes with good impact]
- **Major Refactoring**: [Large changes needed]

---

## Technical Debt Assessment

### High Priority Issues
1. **[Issue]**: 
   - **Impact**: [Business/Technical impact]
   - **Effort**: [Days/Hours estimated]
   - **Risk**: [High/Medium/Low]

2. **[Issue]**:
   - **Impact**: [Business/Technical impact] 
   - **Effort**: [Days/Hours estimated]
   - **Risk**: [High/Medium/Low]

### Medium Priority Issues
- [Issue]: [Brief description and impact]
- [Issue]: [Brief description and impact]

### Low Priority Issues / Nice-to-Haves
- [Issue]: [Brief description]
- [Issue]: [Brief description]

### Technical Debt Score: [X]/10
**Rationale**: [Why this score - what drives it up/down]

---

## Missing Components

### Documentation
- [ ] **API Documentation**: [Status and needs]
- [ ] **Setup Instructions**: [Quality of existing docs]
- [ ] **Architecture Documentation**: [Missing/Incomplete]
- [ ] **Deployment Guide**: [Available/Missing]

### Development Infrastructure
- [ ] **CI/CD Pipeline**: [Status]
- [ ] **Automated Testing**: [Coverage and quality]
- [ ] **Code Quality Tools**: [Linting, formatting]
- [ ] **Monitoring/Logging**: [Production observability]

### Production Readiness
- [ ] **Environment Configuration**: [Development vs Production]
- [ ] **Error Handling**: [Comprehensive/Basic]
- [ ] **Backup Strategy**: [Present/Missing]
- [ ] **Disaster Recovery**: [Planned/Not planned]

---

## Business Logic Analysis

### Core Features Implemented
1. **[Feature Name]**: [Description of what's implemented]
   - **Completeness**: [Fully/Partially implemented]
   - **Quality**: [Well/Adequately/Poorly implemented]

2. **[Feature Name]**: [Description of what's implemented]
   - **Completeness**: [Fully/Partially implemented]
   - **Quality**: [Well/Adequately/Poorly implemented]

### User Flows Identified
1. **[User Flow]**: [Description of the flow]
2. **[User Flow]**: [Description of the flow]

### Integration Points
- **External APIs**: [List of external services integrated]
- **Third-party Services**: [Payment, auth, analytics, etc.]
- **Data Sources**: [Databases, files, external feeds]

---

## Recommendations

### Immediate Actions (Next 1-2 weeks)
1. **[Action]**: [Why important and how to do it]
2. **[Action]**: [Why important and how to do it]
3. **[Action]**: [Why important and how to do it]

### Short-term Improvements (1-3 months)
1. **[Improvement]**: [Description and business value]
2. **[Improvement]**: [Description and business value]

### Long-term Strategic Changes (3-12 months)  
1. **[Strategic Change]**: [Vision and approach]
2. **[Strategic Change]**: [Vision and approach]

### Architecture Evolution
- **Current → Target**: [High-level migration path]
- **Key Milestones**: [Major checkpoints in evolution]
- **Risk Mitigation**: [How to minimize risks during transition]

---

## Resource Requirements

### Team Skills Needed
- **[Skill Area]**: [Current gap and training needs]
- **[Skill Area]**: [Current gap and training needs]

### Infrastructure Requirements
- **Development**: [Tooling and environment needs]
- **Staging**: [Requirements for proper testing]
- **Production**: [Scaling and reliability needs]

### Time Investment Estimates
- **Critical Issues**: [X] days/weeks
- **Quality Improvements**: [X] days/weeks  
- **Strategic Changes**: [X] months

---

## Next Steps

### Phase 1: Stabilization ([X] weeks)
- [ ] **Fix critical security issues**
- [ ] **Address high-priority bugs**
- [ ] **Improve test coverage to [X]%**
- [ ] **Update critical dependencies**

### Phase 2: Quality & Performance ([X] weeks)
- [ ] **Implement code quality standards**
- [ ] **Optimize performance bottlenecks**
- [ ] **Add comprehensive logging**
- [ ] **Improve error handling**

### Phase 3: Modernization ([X] months)
- [ ] **Architecture improvements**
- [ ] **Framework/dependency upgrades**  
- [ ] **Enhanced security measures**
- [ ] **Production monitoring setup**

### Success Metrics
- **Code Quality Score**: [Current] → [Target]
- **Security Score**: [Current] → [Target] 
- **Performance**: [Current] → [Target]
- **Test Coverage**: [Current]% → [Target]%

---

## Appendices

### A. Detailed File Inventory
[List of all major files with brief descriptions]

### B. Dependency Analysis
[Complete list of dependencies with versions and status]

### C. Security Scan Results
[Detailed security findings if tools were used]

### D. Performance Profiling Data
[Any performance measurements taken]

---

*Analysis generated by Agentic Seed Rescue Mode*  
*For questions about this analysis, review the improvement plan in `.output/improvement-plan.md`*