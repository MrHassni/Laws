import 'package:flutter/material.dart';
import 'package:laws/constants/constants.dart';

class CovidRegulationsScreen extends StatelessWidget {
  const CovidRegulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 25,
                        color: Colors.brown.shade500,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Covid Regulations',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade500),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Certainly, I can provide a more detailed overview of COVID-19 regulations as of my last update in September 2021. Please note that these details might not reflect the latest developments, so it's important to verify with current sources.",
                style: TextStyle(letterSpacing: 1.25, fontSize: 14.5),
              ),
              const SectionHeader('Vaccination Campaigns'),
              const InfoCard([
                "Countries have been working on vaccination campaigns to provide immunity against COVID-19. Vaccines from various manufacturers, such as Pfizer-BioNTech, Moderna, AstraZeneca, and Johnson & Johnson, were authorized for emergency use or full approval. \n⦿ Vaccination eligibility varied, often prioritizing frontline workers, elderly populations, and individuals with underlying health conditions."
                // Add more bullet points here
              ]),
              const SectionHeader('Mask Mandates'),
              const InfoCard([
                'Many regions required the use of face masks in indoor public spaces, public transportation, and crowded outdoor areas where maintaining physical distance is difficult.',
                // Add more bullet points here
              ]),
              const SectionHeader('Social Distancing'),
              const InfoCard([
                'Regulations recommended maintaining a physical distance of around 1 to 2 meters (3 to 6 feet) from others to prevent virus transmission.',
                // Add more bullet points here
              ]),
              const SectionHeader('Travel Restrictions'),
              const InfoCard([
                'Travel advisories and restrictions were common, with some countries closing borders or implementing mandatory quarantine for travelers arriving from high-risk areas. \n⦿ Some regions introduced a "travel bubble" concept, allowing quarantine-free travel between countries with low infection rates.',
                // Add more bullet points here
              ]),
              const SectionHeader('Gathering Limits'),
              const InfoCard([
                'Regulations placed limits on the number of people allowed to gather for various events, including weddings, funerals, and religious services. The number often depended on the severity of the pandemic in a specific area.',
                // Add more bullet points here
              ]),
              const SectionHeader('Business and Venue Regulations'),
              const InfoCard([
                'Restaurants, bars, gyms, and entertainment venues were subject to capacity limits to enable physical distancing. Some areas permitted outdoor dining to reduce indoor transmission risks. \n⦿ Businesses were required to implement safety measures, including enhanced cleaning protocols and protective barriers.',
                // Add more bullet points here
              ]),
              const SectionHeader('Remote Work'),
              const InfoCard([
                'Many workplaces adopted remote work policies to minimize the number of employees in physical offices, reducing the risk of virus transmission.',
                // Add more bullet points here
              ]),
              const SectionHeader('Quarantine and Isolation Guidelines'),
              const InfoCard([
                'Individuals who tested positive for COVID-19 were advised to isolate themselves to prevent spreading the virus. Isolation typically lasted for a specified number of days or until symptoms improved. \n⦿ Close contacts of positive cases were asked to quarantine for a certain period to monitor for symptoms and prevent potential transmission',
                // Add more bullet points here
              ]),
              const SectionHeader('Testing Requirements'),
              const InfoCard([
                'Some regions required negative COVID-19 test results before traveling, attending large events, or entering the country. Testing options included PCR tests and rapid antigen tests.',
                // Add more bullet points here
              ]),
              const SectionHeader('Health Passports'),
              const InfoCard([
                'Some areas introduced digital health passports or certificates as proof of vaccination or recent negative test results. These could be required for international travel or entry into certain venues.',
                // Add more bullet points here
              ]),
              const SectionHeader('School and Education Regulations'),
              const InfoCard([
                'Education systems adapted to a mix of in-person, hybrid, and remote learning based on the local COVID-19 situation.\n⦿ Safety measures, such as staggered schedules, reduced class sizes, and enhanced cleaning, were implemented in schools.',
                // Add more bullet points here
              ]),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.brown.shade500),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final List<String> points;

  const InfoCard(this.points, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kAppBrown.withOpacity(0.25),
      elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          //set border radius more than 50% of height and width to make circle
        ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: points.map((point) => InfoPoint(point)).toList(),
        ),
      ),
    );
  }
}

class InfoPoint extends StatelessWidget {
  final String text;

  const InfoPoint(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text('⦿ $text');
  }
}
