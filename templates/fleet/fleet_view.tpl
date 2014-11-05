<h3>Aircraft Information for <strong><?php echo $basicinfo->registration; ?></strong> </h3>
<h4>Basic Information</h4>
<table width="100%">
	<tbody>
		<tr>
			<td rowspan="4"><img src="<?php echo $basicinfo->imagelink; ?>" alt="No Images Available" width="160px"/></td>
			<td><strong>Type: </strong> <?php echo $basicinfo->fullname . "(" . $basicinfo->icao . ")"; ?></td>
			<td><strong>Range: </strong> <?php echo $basicinfo->range; ?><i>miles</i></td>
		</tr>
		<tr>
			<td><strong>Max Cargo: </strong> <?php echo $basicinfo->maxcargo; ?><i>lbs</i></td>
			<td><strong>Max Passengers: </strong> <?php echo $basicinfo->maxpax; ?><i>pax</i></td>
		</tr>
		<tr>
			<td><strong>Weight: </strong> <?php echo $basicinfo->weight; ?><i>lbs</i></td>
			<td><strong>Max Cruise Alt: </strong> <?php echo $basicinfo->cruise; ?><i>ft</i></td>
		</tr>
<tr>
			<td><?php if($basicinfo->downloadlink != null){ ?><a href="<?php echo $basicinfo->downloadlink; ?>" class="button">Download Aircraft</a><?php } else{ echo "No current download links"; } ?></td>
			<td></td>
		</tr>
	</tbody>
</table>
<h3>Detailed Information</h3>
<table width="100%">
	<tbody>
		<tr>
			<td><strong>Average fuel use per flight: </strong><?php echo round($detailedinfo['AvgFuel'], 2); ?><i>lbs</i></td>
			<td><strong>Total fuel used: </strong> <?php echo round($detailedinfo['totalFuel'], 2); ?><i>lbs</i></td>
			<td><strong>Fuel consumption rate: </strong> <?php echo round($detailedinfo['fuelConsumption'], 2); ?><i>lbs/mile</i></td>
		</tr>
		<tr>
			<td><strong>Average Flight Distance per flight: </strong> <?php echo round($detailedinfo['fuelConsumption'], 2); ?><i>miles</i></td>
			<td><strong>Total Flight Distance: </strong> <?php echo round($detailedinfo['TotalFlightDistance'], 2); ?><i>miles</i></td>
			<td><strong>Average Revenue: </strong> $<?php echo round($detailedinfo['AvgRevenue'], 2); ?><i></i></td>
		</tr>
		<tr>
			<td><strong>Total Revenue: </strong> $<?php echo round($detailedinfo['totalRevenue'], 2); ?><i></i></td>
			<td><strong>Total Expenses: </strong>$<?php echo round($detailedinfo['totalExpenses'], 2); ?><i></i></td>
			<td><strong>Date of Purchase: </strong><?php echo date('l d F Y', strtotime($purchasedate->datestamp)); ?></td>
		</tr>
	</tbody>
</table>
<h3>Most recent flights</h3>
<table width="100%">
	<thead>
		<tr>
			<th>Flight Number</th>
			<th>Departure</th>
			<th>Arrival</th>
			<th>Pilot In Command</th>
			<th>Distance</th>
			<th>Revenue</th>
			
			<th>Landing Rate</th>
		</tr>
	</thead>
	<tbody style="text-align:center;"><?php if($recentflights != null){foreach($recentflights as $recentflight){ ?>
		<tr>
			<td><a href="<?php echo url('pireps/view/' . $recentflight->pirepid); ?>/" ><?php echo $recentflight->code . " " . $recentflight->flightnum; ?></a></td>
			<td><?php echo $recentflight->depicao; ?></td>
			<td><?php echo $recentflight->arricao; ?></td>
			<td><?php echo PilotData::getPilotData($recentflight->pilotid)->firstname. " " .PilotData::getPilotData($recentflight->pilotid)->lastname; ?></td>
			<td><?php echo $recentflight->distance; ?><i>miles</i></td>
			<td style="color:<?php if($recentflight->revenue >0){ echo 'green'; }else{ echo 'red'; } ?> ;">$<?php echo $recentflight->revenue; ?></td>
		
			<td>-<?php echo $recentflight->landingrate; ?>ft/min</td>
			
		</tr>
		<?php } } ?>
	</tbody>
</table>

<h3>Scheduled Flights</h3>
<table width="100%">
	<thead >
		<tr>
			<th>Flight Number</th>
			<th>Departure</th>
			<th>Arrival</th>
			<th>Dep time</th>
			<th>Arr time</th>
			<th>Distance</th>
			<th>Flight Duration</th>
		</tr>
	</thead>
	<tbody style="text-align:center;"><?php if($scheduledflights != null){foreach($scheduledflights as $scheduledflights){ ?>
		<tr>
			<td><?php echo $scheduledflights->code . " " . $scheduledflights->flightnum; ?></td>
			<td><?php echo $scheduledflights->depicao; ?></td>
			<td><?php echo $scheduledflights->arricao; ?></td>
			<td><?php echo $scheduledflights->deptime; ?></td>
			<td><?php echo $scheduledflights->arrtime; ?></td>
			<td><?php echo $scheduledflights->distance; ?><i>miles</i></td>
			<td><?php echo $scheduledflights->flighttime; ?><i></i></td>
			
			
		</tr>
		<?php } } ?>
	</tbody>
</table>
<h3>Aircraft Rentability</h3>
<?php
include('chart.php');

// demonstration of a line chart and formatted array
$chart = new Chart('LineChart');
$x = 0;
$revenue_1 = $recentflights[0]->revenue;
$revenue_2 = $recentflights[1]->revenue;
$revenue_3 = $recentflights[2]->revenue;
$revenue_4 = $recentflights[3]->revenue;
$revenue_5 = $recentflights[4]->revenue;

$data = array(
        'cols' => array(
                array('id' => '', 'label' => 'Year', 'type' => 'string'),
                array('id' => '', 'label' => 'Revenue', 'type' => 'number')
               
        ),
        'rows' => array(
	
                array('c' => array(array('v' => 1), array('v' => $revenue_1))),
                array('c' => array(array('v' => 2), array('v' => $revenue_2))),
                array('c' => array(array('v' => 3), array('v' => $revenue_3))),
                array('c' => array(array('v' => 4), array('v' => $revenue_4))),
                array('c' => array(array('v' => 5), array('v' => $revenue_5))),
     
        
                
        )
);
$chart->load(json_encode($data));
$options = array('theme' => 'maximized');
echo $chart->draw('chart_div', $options);
?>
<div id="chart_div" style="width: 100%; height: 600px;"></div>