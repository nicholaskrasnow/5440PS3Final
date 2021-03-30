# ----------------------------------------------------------------------------------- #
# Copyright (c) 2018 Varnerlab
# Robert Frederick Smith School of Chemical and Biomolecular Engineering
# Cornell University, Ithaca NY 14850
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# ----------------------------------------------------------------------------------- #

# ----------------------------------------------------------------------------------- #
# Function: generate_problem_dictionary
# Description: Holds simulation and model parameters as key => value pairs in a Julia Dict()
# Generated on: 2018-03-15T00:00:56.939
#
# Output arguments:
# data_dictionary::Dict{AbstractString,Any} => Dictionary holding model and simulation parameters as key => value pairs
# ----------------------------------------------------------------------------------- #
function generate_problem_dictionary()

	# Load the stoichiometric network from disk -
	path_to_network_file = joinpath(_PATH_TO_CONFIG,"stoichiometricArray.XLSX")
	stoichiometric_matrix = XLSX.readdata(path_to_network_file,"Sheet1!B2:Z19");
	stoichiometric_matrix =Array{Float64,2}(stoichiometric_matrix)

	# What is the system dimension? -
	(number_of_species,number_of_reactions) = size(stoichiometric_matrix)

	# Setup the flux bounds array -
	flux_bounds_array = zeros(number_of_reactions,2)
	# TODO: update the flux_bounds_array for each reaction in your network
	# TODO: col 1 => lower bound
	# TODO: col 2 => upper bound
	# TODO: each row is a reaction

# constrain the enzyme-catalyzed reactions to the maximum rates (umol*g^-1*s^-1)

flux_bounds_array[1,1]=0;
flux_bounds_array[1,2]=2.03;
flux_bounds_array[2,1]=0;
flux_bounds_array[2,2]=0.345;
flux_bounds_array[3,1]=0;
flux_bounds_array[3,2]=2.49;
flux_bounds_array[4,1]=0;
flux_bounds_array[4,2]=0.881;
flux_bounds_array[5,1]=0;
flux_bounds_array[5,2]=0.137;
flux_bounds_array[6,1]=0;
flux_bounds_array[6,2]=0.137;

# constrain the fluxes in and out to 2.8 umol *g^-1 *s^-1
for i=7:25
flux_bounds_array[i,2]=2.8;
end

	# Setup default species bounds array -
	species_bounds_array = zeros(number_of_species,2)
	# TODO: NOTE - we by default assume Sv = 0, so species_bounds_array should be a M x 2 array of zeros
	# TODO: however, if you formulate the problem differently you *may* need to change this 

	# Min/Max flag - default is minimum -
	is_minimum_flag = false

	# Setup the objective coefficient array -
	objective_coefficient_array = zeros(number_of_reactions)
	# TODO: update me to maximize Urea production (Urea leaving the virtual box) 
	# TODO: if is_minimum_flag = true => put a -1 in the index for Urea export

	objective_coefficient_array[10]=1
	
	
	# =============================== DO NOT EDIT BELOW THIS LINE ============================== #
	data_dictionary = Dict{String,Any}()
	data_dictionary["stoichiometric_matrix"] = stoichiometric_matrix
	data_dictionary["objective_coefficient_array"] = objective_coefficient_array
	data_dictionary["flux_bounds_array"] = flux_bounds_array;
	data_dictionary["species_bounds_array"] = species_bounds_array
	data_dictionary["is_minimum_flag"] = is_minimum_flag
	data_dictionary["number_of_species"] = number_of_species
	data_dictionary["number_of_reactions"] = number_of_reactions
	# =============================== DO NOT EDIT ABOVE THIS LINE ============================== #
	return data_dictionary
end
