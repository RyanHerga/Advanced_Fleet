<h3><?php echo SITE_NAME; ?> Fleet</h3>

<table width="100%" style="text-align:center;">
	<thead>
		<tr>
			<th>Aircraft Registration</th>
			<th>Aircraft Type</th>
			<th>Range</th>
			<th>Max Passengers</th>
			<th>Max Cargo</th>
			<th>Details</th>
		</tr>
	</thead>
	<tbody>
	<?php if($aircrafts != null){ foreach($aircrafts as $aircrafts){ ?>
		<tr>
			<td><?php echo $aircrafts->registration; ?></td>
			<td><?php echo $aircrafts->fullname; ?></td>
			<td><?php echo $aircrafts->range; ?><i>miles</i></td>
			<td><?php echo $aircrafts->maxpax; ?></td>
			<td><?php echo $aircrafts->maxcargo; ?></td>
			<td><a href="<?php echo url('fleet/view/' . $aircrafts->id); ?>">View</a></td>
		</tr>
	<?php } }?>
	</tbody>
</table>