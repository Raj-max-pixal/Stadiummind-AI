import google.generativeai as genai
from typing import Optional, Dict, Any
from app.config import settings
import logging

logger = logging.getLogger(__name__)


class GeminiService:
    def __init__(self):
        genai.configure(api_key=settings.gemini_api_key)
        self.model = genai.GenerativeModel('gemini-1.5-flash')
        self.pro_model = genai.GenerativeModel('gemini-1.5-pro')
    
    async def generate_response(
        self,
        prompt: str,
        use_pro_model: bool = False,
        temperature: float = 0.7,
        max_tokens: int = 1000
    ) -> str:
        try:
            model = self.pro_model if use_pro_model else self.model
            generation_config = genai.GenerationConfig(
                temperature=temperature,
                max_output_tokens=max_tokens,
            )
            
            response = model.generate_content(
                prompt,
                generation_config=generation_config
            )
            
            return response.text
        except Exception as e:
            logger.error(f"Gemini API error: {str(e)}")
            raise
    
    async def generate_with_chain_of_thought(
        self,
        query: str,
        context: Dict[str, Any]
    ) -> Dict[str, Any]:
        prompt = f"""
You are an AI Operations Copilot for FIFA World Cup 2026 stadium operations.

Context:
{context}

User Query:
{query}

Think step-by-step and provide:
1. Analysis of the situation
2. Reasoning for your recommendation
3. Specific action items
4. Expected impact

Format your response as:
ANALYSIS: [your analysis]
REASONING: [your reasoning]
RECOMMENDATION: [your recommendation]
ACTION_ITEMS: [list of actions]
EXPECTED_IMPACT: [expected outcome]
"""
        
        try:
            response = await self.generate_response(prompt, use_pro_model=True)
            
            # Parse the response
            result = {
                "analysis": "",
                "reasoning": "",
                "recommendation": "",
                "action_items": [],
                "expected_impact": ""
            }
            
            current_section = None
            for line in response.split('\n'):
                if line.startswith('ANALYSIS:'):
                    current_section = 'analysis'
                    result['analysis'] = line.replace('ANALYSIS:', '').strip()
                elif line.startswith('REASONING:'):
                    current_section = 'reasoning'
                    result['reasoning'] = line.replace('REASONING:', '').strip()
                elif line.startswith('RECOMMENDATION:'):
                    current_section = 'recommendation'
                    result['recommendation'] = line.replace('RECOMMENDATION:', '').strip()
                elif line.startswith('ACTION_ITEMS:'):
                    current_section = 'action_items'
                elif line.startswith('EXPECTED_IMPACT:'):
                    current_section = 'expected_impact'
                    result['expected_impact'] = line.replace('EXPECTED_IMPACT:', '').strip()
                elif current_section == 'action_items' and line.strip():
                    result['action_items'].append(line.strip().lstrip('- '))
            
            return result
        except Exception as e:
            logger.error(f"Chain of thought error: {str(e)}")
            raise
    
    async def generate_executive_briefing(
        self,
        stadium_data: Dict[str, Any]
    ) -> str:
        prompt = f"""
Generate an executive briefing for stadium operations based on the following data:

Stadium Data:
- Total Attendance: {stadium_data.get('attendance', 'N/A')}
- Peak Crowd Time: {stadium_data.get('peak_time', 'N/A')}
- Active Emergencies: {stadium_data.get('emergencies', 'N/A')}
- Average Response Time: {stadium_data.get('response_time', 'N/A')}
- Gate Status: {stadium_data.get('gate_status', 'N/A')}
- AI Interventions: {stadium_data.get('ai_interventions', 'N/A')}

Provide a concise executive summary (3-4 sentences) highlighting:
1. Current stadium status
2. Key metrics
3. AI actions taken
4. Predictions and recommendations

Keep it professional and actionable for stadium executives.
"""
        
        return await self.generate_response(prompt, use_pro_model=True)
    
    async def generate_emergency_analysis(
        self,
        incident_type: str,
        location: str,
        description: str
    ) -> Dict[str, Any]:
        prompt = f"""
Analyze this emergency incident for FIFA World Cup 2026 stadium:

Incident Type: {incident_type}
Location: {location}
Description: {description}

Provide:
1. Priority assessment (LOW/MEDIUM/HIGH/CRITICAL)
2. Recommended response actions
3. Nearest resources needed
4. Estimated resolution time
5. Potential impact on operations

Format as:
PRIORITY: [level]
RESPONSE_ACTIONS: [list]
NEAREST_RESOURCES: [list]
ESTIMATED_RESOLUTION: [time]
OPERATIONAL_IMPACT: [assessment]
"""
        
        try:
            response = await self.generate_response(prompt, use_pro_model=True)
            
            result = {
                "priority": "MEDIUM",
                "response_actions": [],
                "nearest_resources": [],
                "estimated_resolution": "10 minutes",
                "operational_impact": ""
            }
            
            current_section = None
            for line in response.split('\n'):
                if line.startswith('PRIORITY:'):
                    result['priority'] = line.replace('PRIORITY:', '').strip()
                elif line.startswith('RESPONSE_ACTIONS:'):
                    current_section = 'response_actions'
                elif line.startswith('NEAREST_RESOURCES:'):
                    current_section = 'nearest_resources'
                elif line.startswith('ESTIMATED_RESOLUTION:'):
                    result['estimated_resolution'] = line.replace('ESTIMATED_RESOLUTION:', '').strip()
                elif line.startswith('OPERATIONAL_IMPACT:'):
                    result['operational_impact'] = line.replace('OPERATIONAL_IMPACT:', '').strip()
                elif current_section in ['response_actions', 'nearest_resources'] and line.strip():
                    item = line.strip().lstrip('- ')
                    if current_section == 'response_actions':
                        result['response_actions'].append(item)
                    else:
                        result['nearest_resources'].append(item)
            
            return result
        except Exception as e:
            logger.error(f"Emergency analysis error: {str(e)}")
            raise
    
    async def translate_text(
        self,
        text: str,
        target_language: str
    ) -> str:
        prompt = f"""
Translate the following text to {target_language}:

Text: {text}

Provide only the translation, no explanations.
"""
        
        return await self.generate_response(prompt)
    
    async def generate_crowd_prediction(
        self,
        gate_data: Dict[str, Any],
        historical_data: Dict[str, Any]
    ) -> Dict[str, Any]:
        prompt = f"""
Predict crowd congestion for this stadium gate:

Current_GATE_Data:
- Gate ID: {gate_data.get('gate_id')}
- Current Percentage: {gate_data.get('percentage')}%
- Current Count: {gate_data.get('current_count')}
- Capacity: {gate_data.get('capacity')}

Historical Patterns:
{historical_data}

Provide:
1. Predicted percentage in 15 minutes
2. Time until congestion (if applicable)
3. Confidence level (0-1)
4. Reasoning for prediction
5. Recommendation

Format as:
PREDICTED_PERCENTAGE: [number]
TIME_TO_CONGESTION: [minutes or "N/A"]
CONFIDENCE: [0-1]
REASONING: [explanation]
RECOMMENDATION: [action]
"""
        
        try:
            response = await self.generate_response(prompt)
            
            result = {
                "predicted_percentage": gate_data.get('percentage', 50),
                "time_to_congestion": None,
                "confidence": 0.7,
                "reasoning": "",
                "recommendation": ""
            }
            
            for line in response.split('\n'):
                if line.startswith('PREDICTED_PERCENTAGE:'):
                    result['predicted_percentage'] = float(line.replace('PREDICTED_PERCENTAGE:', '').strip().rstrip('%'))
                elif line.startswith('TIME_TO_CONGESTION:'):
                    time_str = line.replace('TIME_TO_CONGESTION:', '').strip()
                    if time_str != "N/A":
                        result['time_to_congestion'] = int(time_str)
                elif line.startswith('CONFIDENCE:'):
                    result['confidence'] = float(line.replace('CONFIDENCE:', '').strip())
                elif line.startswith('REASONING:'):
                    result['reasoning'] = line.replace('REASONING:', '').strip()
                elif line.startswith('RECOMMENDATION:'):
                    result['recommendation'] = line.replace('RECOMMENDATION:', '').strip()
            
            return result
        except Exception as e:
            logger.error(f"Crowd prediction error: {str(e)}")
            raise


# Singleton instance
gemini_service = GeminiService()
