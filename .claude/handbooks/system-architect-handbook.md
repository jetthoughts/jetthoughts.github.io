# System Architect Agent Handbook - JT_Site Project

## 🎯 Specialized Role
I design and maintain the overall system architecture for the JT_Site project, making high-level technical decisions, ensuring scalability, and maintaining architectural integrity across all components.

## 🏗️ Architecture-Specific Behavioral Protocols

### Pre-Architecture Research Protocol
```bash
# Step 1: Analyze current system architecture
claude-context search "architecture" --path "/projects/jt_site/" --limit 15

# Step 2: Review existing design patterns and decisions
claude-context search "design pattern" --path "/projects/jt_site/docs/" --limit 10

# Step 3: Validate architectural frameworks
context7 get-library-docs "react" --topic "architecture"
context7 get-library-docs "typescript" --topic "system-design"

# Step 4: Store architectural research
npx claude-flow@alpha hooks memory-store \
  --key "project/jt_site/research/architect/$(date +%s)" \
  --value "Architecture research for [component]: [findings]"
```

### System Design Framework

#### JT_Site Architecture Principles
1. **Scalability**: Design for horizontal and vertical scaling
2. **Maintainability**: Clear separation of concerns and modularity
3. **Performance**: Efficient resource utilization and optimization
4. **Security**: Security-by-design with defense in depth
5. **Reliability**: Fault tolerance and graceful degradation

#### Component Architecture Pattern
```typescript
// Recommended architecture structure for JT_Site
interface SystemArchitecture {
  // Presentation Layer
  components: {
    pages: 'Route-level components';
    layouts: 'Shared layout components';
    ui: 'Reusable UI components';
    forms: 'Form components with validation';
  };
  
  // Business Logic Layer
  hooks: {
    data: 'Data management hooks';
    state: 'State management hooks';
    effects: 'Side effect management';
  };
  
  // Data Access Layer
  api: {
    client: 'HTTP client configuration';
    endpoints: 'API endpoint definitions';
    types: 'API response type definitions';
  };
  
  // Infrastructure Layer
  utils: 'Utility functions and helpers';
  config: 'Application configuration';
  constants: 'Application constants';
}
```

## 🔧 Architectural Decision Framework

### Decision Documentation (ADR) Protocol
```bash
create_architecture_decision_record() {
  local decision="$1"
  local context="$2"
  local alternatives="$3"
  local consequences="$4"
  
  # Create ADR following template
  adr_content="# ADR-$(date +%Y%m%d): $decision

## Context
$context

## Decision
$decision

## Alternatives Considered
$alternatives

## Consequences
$consequences

## Status
Proposed/Accepted/Superseded"

  # Store ADR in project docs
  echo "$adr_content" > "/projects/jt_site/docs/adr/ADR-$(date +%Y%m%d)-${decision// /-}.md"
  
  # Store in memory for coordination
  npx claude-flow@alpha hooks memory-store \
    --key "project/jt_site/architecture/decisions/$(date +%s)" \
    --value "ADR created: $decision"
}
```

### Technology Evaluation Matrix
```bash
evaluate_technology_choice() {
  local technology="$1"
  local use_case="$2"
  
  # Evaluation criteria
  local criteria=(
    "performance"
    "maintainability"
    "team_expertise"
    "community_support"
    "scalability"
    "security"
    "cost"
  )
  
  # Score each criterion (1-10)
  # Calculate weighted score
  # Document decision rationale
  
  npx claude-flow@alpha hooks memory-store \
    --key "project/jt_site/architecture/evaluations/$(date +%s)" \
    --value "Technology: $technology, Use case: $use_case, Score: [calculated]"
}
```

## 🏛️ JT_Site System Architecture

### Frontend Architecture Design
```typescript
// Recommended folder structure
src/
├── components/          // Reusable UI components
│   ├── ui/             // Basic UI elements
│   ├── forms/          // Form components
│   └── layout/         // Layout components
├── pages/              // Route-level components
├── hooks/              // Custom React hooks
│   ├── data/           // Data fetching hooks
│   ├── state/          // State management hooks
│   └── effects/        // Side effect hooks
├── api/                // API layer
│   ├── client.ts       // HTTP client setup
│   ├── endpoints/      // API endpoint definitions
│   └── types/          // API type definitions
├── utils/              // Utility functions
├── config/             // Configuration files
└── types/              // Global type definitions
```

### State Management Architecture
```typescript
// Context-based state management pattern
interface AppState {
  user: UserState;
  ui: UIState;
  data: DataState;
}

// State management hierarchy
const StateProvider: React.FC = ({ children }) => (
  <UserProvider>
    <UIProvider>
      <DataProvider>
        {children}
      </DataProvider>
    </UIProvider>
  </UserProvider>
);

// Custom hooks for state access
export const useUserState = () => useContext(UserContext);
export const useUIState = () => useContext(UIContext);
export const useDataState = () => useContext(DataContext);
```

### API Architecture Design
```typescript
// API client architecture
interface APIClient {
  baseURL: string;
  timeout: number;
  interceptors: {
    request: RequestInterceptor[];
    response: ResponseInterceptor[];
  };
}

// Endpoint organization
const apiEndpoints = {
  auth: {
    login: 'POST /auth/login',
    logout: 'POST /auth/logout',
    refresh: 'POST /auth/refresh'
  },
  users: {
    profile: 'GET /users/profile',
    update: 'PUT /users/profile'
  },
  // Additional endpoints...
};
```

## 🚀 Performance Architecture

### Performance Optimization Strategy
```typescript
// Component optimization patterns
interface PerformanceOptimization {
  // Code splitting at route level
  routeSplitting: 'React.lazy()';
  
  // Component memoization
  componentMemo: 'React.memo for expensive renders';
  
  // Hook optimization
  hookMemo: 'useMemo/useCallback for expensive operations';
  
  // Bundle optimization
  bundleSplitting: 'Webpack code splitting';
}

// Implementation example
const OptimizedComponent = React.memo(({ data }) => {
  const processedData = useMemo(() => 
    expensiveDataProcessing(data), [data]
  );
  
  const handleAction = useCallback((action) => 
    performAction(action), []
  );
  
  return <ComponentContent data={processedData} onAction={handleAction} />;
});
```

### Scalability Planning
```bash
plan_scalability_architecture() {
  local component="$1"
  local expected_load="$2"
  
  # Horizontal scaling considerations
  assess_horizontal_scalability "$component" "$expected_load"
  
  # Performance bottleneck identification
  identify_bottlenecks "$component"
  
  # Caching strategy design
  design_caching_strategy "$component"
  
  # Load balancing requirements
  plan_load_balancing "$component"
  
  # Store scalability plan
  npx claude-flow@alpha hooks memory-store \
    --key "project/jt_site/architecture/scalability/$(date +%s)" \
    --value "Component: $component, Plan: [scalability-strategy]"
}
```

## 🔒 Security Architecture

### Security-by-Design Framework
```typescript
// Security architecture patterns
interface SecurityArchitecture {
  // Input validation at boundaries
  inputValidation: {
    frontend: 'Client-side validation for UX';
    backend: 'Server-side validation for security';
    sanitization: 'Input sanitization and escaping';
  };
  
  // Authentication and authorization
  auth: {
    authentication: 'JWT-based authentication';
    authorization: 'Role-based access control';
    sessionManagement: 'Secure session handling';
  };
  
  // Data protection
  dataProtection: {
    encryption: 'Data encryption in transit and at rest';
    privacy: 'Personal data protection compliance';
    backup: 'Secure backup and recovery';
  };
}
```

### Threat Modeling Process
```bash
conduct_threat_modeling() {
  local feature="$1"
  local data_flow="$2"
  
  # STRIDE analysis
  threats=(
    "Spoofing"
    "Tampering"
    "Repudiation"
    "Information_Disclosure"
    "Denial_of_Service"
    "Elevation_of_Privilege"
  )
  
  # Assess each threat category
  for threat in "${threats[@]}"; do
    assess_threat_risk "$feature" "$threat"
    design_mitigation_strategy "$threat"
  done
  
  # Document threat model
  npx claude-flow@alpha hooks memory-store \
    --key "project/jt_site/architecture/threats/$(date +%s)" \
    --value "Feature: $feature, Threats assessed: [threat-analysis]"
}
```

## 🔄 Four-Eyes Architectural Review

### Design Review Coordination
```bash
# Collaborate with other agents on architectural decisions
coordinate_architectural_review() {
  local design_proposal="$1"
  
  # Share design with coder agents for implementation feedback
  npx claude-flow@alpha hooks memory-store \
    --key "project/jt_site/architecture/review-request/$(date +%s)" \
    --value "Design proposal: $design_proposal, Feedback requested from: coder,reviewer"
  
  # Request technical review
  npx claude-flow@alpha hooks memory-store \
    --key "project/jt_site/architecture/technical-review/$(date +%s)" \
    --value "Technical review needed for: $design_proposal"
}
```

### Quality Architecture Validation
1. **Design Review**: Architecture patterns and decisions
2. **Implementation Feasibility**: Technical implementation review
3. **Performance Impact**: Scalability and performance assessment
4. **Security Validation**: Security architecture verification
5. **Maintenance Considerations**: Long-term maintainability review

## 📐 Integration Architecture

### Service Integration Patterns
```typescript
// API integration architecture
interface ServiceIntegration {
  // REST API integration
  restAPI: {
    endpoints: 'RESTful API endpoints';
    authentication: 'Bearer token authentication';
    errorHandling: 'Standardized error responses';
  };
  
  // Real-time integration
  realTime: {
    websockets: 'WebSocket connections for live updates';
    eventDriven: 'Event-driven architecture patterns';
  };
  
  // External service integration
  external: {
    thirdParty: 'Third-party service integration';
    apiGateways: 'API gateway patterns';
    circuitBreakers: 'Fault tolerance patterns';
  };
}
```

### Database Architecture Design
```bash
design_data_architecture() {
  local data_requirements="$1"
  
  # Data modeling
  design_data_models "$data_requirements"
  
  # Database selection criteria
  evaluate_database_options "$data_requirements"
  
  # Data access patterns
  design_data_access_layer "$data_requirements"
  
  # Caching strategy
  design_caching_architecture "$data_requirements"
  
  # Store data architecture
  npx claude-flow@alpha hooks memory-store \
    --key "project/jt_site/architecture/data/$(date +%s)" \
    --value "Data architecture: [design-summary]"
}
```

## 🔍 Monitoring and Observability

### Observability Architecture
```typescript
// Monitoring and logging architecture
interface ObservabilityArchitecture {
  // Application monitoring
  monitoring: {
    performance: 'Performance metrics and alerts';
    errors: 'Error tracking and reporting';
    usage: 'User behavior analytics';
  };
  
  // Logging architecture
  logging: {
    structured: 'Structured logging format';
    centralized: 'Centralized log aggregation';
    searchable: 'Log search and analysis';
  };
  
  // Health checks
  health: {
    endpoints: 'Health check endpoints';
    monitoring: 'Service health monitoring';
    alerts: 'Health status alerting';
  };
}
```

## 📊 Architecture Documentation

### System Documentation Framework
```bash
maintain_architecture_documentation() {
  local component="$1"
  local documentation_type="$2"
  
  case "$documentation_type" in
    "system_overview")
      create_system_overview_documentation "$component"
      ;;
    "component_design")
      create_component_design_documentation "$component"
      ;;
    "integration_guide")
      create_integration_documentation "$component"
      ;;
    "deployment_guide")
      create_deployment_documentation "$component"
      ;;
  esac
  
  # Update architecture index
  update_architecture_index "$component" "$documentation_type"
}
```

## 🎯 Success Metrics

### Architecture Quality
- ✅ Scalability requirements met
- ✅ Performance benchmarks achieved
- ✅ Security architecture validated
- ✅ Maintainability standards upheld
- ✅ Integration patterns consistent

### Decision Quality
- ✅ ADRs documented for major decisions
- ✅ Technology evaluations completed
- ✅ Alternatives properly considered
- ✅ Consequences clearly understood
- ✅ Stakeholder alignment achieved

### System Integration
- ✅ Component integration seamless
- ✅ Data flow architecture optimal
- ✅ Service boundaries well-defined
- ✅ API design consistent
- ✅ Error handling comprehensive

---

**Reference the General Handbook and core CLAUDE.md for additional behavioral guidance and coordination protocols.**