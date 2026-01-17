import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../common/widgets/custom_card.dart';

class MetricsTab extends StatelessWidget {
  const MetricsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 4;
          if (constraints.maxWidth < 600) {
            crossAxisCount = 1;
          } else if (constraints.maxWidth < 1100) {
            crossAxisCount = 2;
          }

          return StaggeredGrid.count(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              StaggeredGridTile.fit(
                crossAxisCellCount: crossAxisCount == 1 ? 1 : 2,
                child: const _RevenueChartCard(),
              ),
              const StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: _MetricSummaryCard(
                  title: 'Occupancy',
                  value: '92%',
                  trend: '+2.4%',
                  isPositive: true,
                  icon: Icons.people_outline,
                  iconColor: Colors.blueAccent,
                  contentColor: Colors.blue,
                  titleColor: Colors.white,
                ),
              ),
              const StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: _MetricSummaryCard(
                  title: 'Vacant Units',
                  value: '3',
                  trend: '2 Available',
                  isPositive: false,
                  icon: Icons.meeting_room_outlined,
                  iconColor: Colors.purpleAccent,
                  contentColor: Colors.purpleAccent,
                  titleColor: Colors.white,
                ),
              ),
              StaggeredGridTile.fit(
                crossAxisCellCount:
                    crossAxisCount == 1 ? 1 : (crossAxisCount == 2 ? 2 : 1),
                child: const _RecentActivityList(),
              ),
              StaggeredGridTile.fit(
                crossAxisCellCount: crossAxisCount == 1 ? 1 : 2,
                child: const _QuickActionsCard(),
              ),
              const StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: _MetricSummaryCard(
                  title: 'Requests',
                  value: '12',
                  trend: '-4',
                  isPositive: true,
                  icon: Icons.build_circle_outlined,
                  iconColor: Colors.orange,
                  contentColor: Colors.yellow,
                  titleColor: Colors.white,
                  caption: 'Pending',
                ),
              ),
              const StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: _MetricSummaryCard(
                  title: 'Total Revenue',
                  value: '\$42,500',
                  trend: '+12%',
                  isPositive: true,
                  icon: Icons.attach_money,
                  iconColor: Colors.green,
                  contentColor: Colors.lightGreenAccent,
                  titleColor: Colors.white,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _RevenueChartCard extends StatelessWidget {
  const _RevenueChartCard();

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      isGlass: true,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Revenue Trend',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$124,500',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.arrow_upward, size: 16, color: Colors.green),
                    SizedBox(width: 4),
                    Text(
                      '12.5%',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 250,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.white.withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        );
                        String text;
                        switch (value.toInt()) {
                          case 0:
                            text = 'JAN';
                            break;
                          case 2:
                            text = 'MAR';
                            break;
                          case 4:
                            text = 'MAY';
                            break;
                          case 6:
                            text = 'JUL';
                            break;
                          case 8:
                            text = 'SEP';
                            break;
                          case 10:
                            text = 'NOV';
                            break;
                          default:
                            return Container();
                        }
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(text, style: style),
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 11,
                minY: 0,
                maxY: 6,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3),
                      FlSpot(2.6, 2),
                      FlSpot(4.9, 5),
                      FlSpot(6.8, 3.1),
                      FlSpot(8, 4),
                      FlSpot(9.5, 3),
                      FlSpot(11, 4),
                    ],
                    isCurved: true,
                    color: Colors.purple,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.withOpacity(0.2),
                          Colors.purple.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final bool isPositive;
  final IconData icon;
  final Color iconColor;
  final Color titleColor;
  final Color contentColor;
  final String? caption;

  const _MetricSummaryCard({
    required this.title,
    required this.value,
    required this.trend,
    required this.isPositive,
    required this.icon,
    required this.contentColor,
    required this.titleColor,
    required this.iconColor,
    this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      isGlass: true,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              if (caption != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: contentColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    caption!,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: contentColor,
                  height: 1,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: titleColor,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    trend,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isPositive ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActionsCard extends StatelessWidget {
  const _QuickActionsCard();

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      isGlass: true,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildActionButton(context, 'Add Unit',
                  Icons.add_home_work_outlined, Colors.blue),
              const SizedBox(width: 12),
              _buildActionButton(context, 'New Lease',
                  Icons.description_outlined, Colors.purple),
              const SizedBox(width: 12),
              _buildActionButton(
                  context, 'Payment', Icons.payments_outlined, Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, String label, IconData icon, Color color) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RecentActivityList extends StatelessWidget {
  const _RecentActivityList();

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      isGlass: true,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Icon(Icons.history, size: 20, color: Colors.white),
            ],
          ),
          const SizedBox(height: 20),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            separatorBuilder: (context, index) =>
                Divider(height: 24, color: Colors.white.withOpacity(0.1)),
            itemBuilder: (context, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      color: [
                        Colors.blue,
                        Colors.green,
                        Colors.orange,
                        Colors.purple,
                        Colors.red
                      ][index],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          [
                            'Payment Received',
                            'New Request',
                            'Lease Signing',
                            'Unit Vacated',
                            'Maintenance'
                          ][index],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Unit 10${index + 1} • 2 hours ago',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
