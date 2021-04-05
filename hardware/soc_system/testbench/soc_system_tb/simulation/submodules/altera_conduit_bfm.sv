// (C) 2001-2016 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/main/ip/sopc/components/verification/altera_tristate_conduit_bfm/altera_tristate_conduit_bfm.sv.terp#7 $
// $Revision: #7 $
// $Date: 2010/08/05 $
// $Author: klong $
//-----------------------------------------------------------------------------
// =head1 NAME
// altera_conduit_bfm
// =head1 SYNOPSIS
// Bus Functional Model (BFM) for a Standard Conduit BFM
//-----------------------------------------------------------------------------
// =head1 DESCRIPTION
// This is a Bus Functional Model (BFM) for a Standard Conduit Master.
// This BFM sampled the input/bidirection port value or driving user's value to 
// output ports when user call the API.  
// This BFM's HDL is been generated through terp file in Qsys/SOPC Builder.
// Generation parameters:
// output_name:                                       altera_conduit_bfm
// role:width:direction:                              rw:1:output,address:32:output,data_in:32:output,data_out:32:input,acknowledgement:1:input
// 1
//-----------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module altera_conduit_bfm
(
   clk,
   reset,
   reset_n,
   sig_rw,
   sig_address,
   sig_data_in,
   sig_data_out,
   sig_acknowledgement
);

   //--------------------------------------------------------------------------
   // =head1 PINS 
   // =head2 User defined interface
   //--------------------------------------------------------------------------
   input clk;
   input reset;
   input reset_n;
   output sig_rw;
   output [31 : 0] sig_address;
   output [31 : 0] sig_data_in;
   input [31 : 0] sig_data_out;
   input sig_acknowledgement;

   // synthesis translate_off
   import verbosity_pkg::*;
   
   typedef logic ROLE_rw_t;
   typedef logic [31 : 0] ROLE_address_t;
   typedef logic [31 : 0] ROLE_data_in_t;
   typedef logic [31 : 0] ROLE_data_out_t;
   typedef logic ROLE_acknowledgement_t;

   reg sig_rw_temp;
   reg sig_rw_out;
   reg [31 : 0] sig_address_temp;
   reg [31 : 0] sig_address_out;
   reg [31 : 0] sig_data_in_temp;
   reg [31 : 0] sig_data_in_out;
   logic [31 : 0] sig_data_out_in;
   logic [31 : 0] sig_data_out_local;
   logic [0 : 0] sig_acknowledgement_in;
   logic [0 : 0] sig_acknowledgement_local;

   //--------------------------------------------------------------------------
   // =head1 Public Methods API
   // =pod
   // This section describes the public methods in the application programming
   // interface (API). The application program interface provides methods for 
   // a testbench which instantiates, controls and queries state in this BFM 
   // component. Test programs must only use these public access methods and 
   // events to communicate with this BFM component. The API and module pins
   // are the only interfaces of this component that are guaranteed to be
   // stable. The API will be maintained for the life of the product. 
   // While we cannot prevent a test program from directly accessing internal
   // tasks, functions, or data private to the BFM, there is no guarantee that
   // these will be present in the future. In fact, it is best for the user
   // to assume that the underlying implementation of this component can 
   // and will change.
   // =cut
   //--------------------------------------------------------------------------
   
   event signal_reset_asserted;
   event signal_input_data_out_change;
   event signal_input_acknowledgement_change;
   
   function automatic string get_version();  // public
      // Return BFM version string. For example, version 9.1 sp1 is "9.1sp1" 
      string ret_version = "16.0";
      return ret_version;
   endfunction

   // -------------------------------------------------------
   // rw
   // -------------------------------------------------------

   function automatic void set_rw (
      ROLE_rw_t new_value
   );
      // Drive the new value to rw.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_rw_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // address
   // -------------------------------------------------------

   function automatic void set_address (
      ROLE_address_t new_value
   );
      // Drive the new value to address.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_address_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // data_in
   // -------------------------------------------------------

   function automatic void set_data_in (
      ROLE_data_in_t new_value
   );
      // Drive the new value to data_in.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_data_in_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // data_out
   // -------------------------------------------------------
   function automatic ROLE_data_out_t get_data_out();
   
      // Gets the data_out input value.
      $sformat(message, "%m: called get_data_out");
      print(VERBOSITY_DEBUG, message);
      return sig_data_out_in;
      
   endfunction

   // -------------------------------------------------------
   // acknowledgement
   // -------------------------------------------------------
   function automatic ROLE_acknowledgement_t get_acknowledgement();
   
      // Gets the acknowledgement input value.
      $sformat(message, "%m: called get_acknowledgement");
      print(VERBOSITY_DEBUG, message);
      return sig_acknowledgement_in;
      
   endfunction

   always @(posedge clk) begin
      sig_rw_out <= sig_rw_temp;
      sig_address_out <= sig_address_temp;
      sig_data_in_out <= sig_data_in_temp;
      sig_data_out_in <= sig_data_out;
      sig_acknowledgement_in <= sig_acknowledgement;
   end
   
   assign sig_rw = sig_rw_out;
   assign sig_address = sig_address_out;
   assign sig_data_in = sig_data_in_out;

   always @(posedge reset or negedge reset_n) begin
      -> signal_reset_asserted;
   end

   always @(sig_data_out_in) begin
      if (sig_data_out_local != sig_data_out_in)
         -> signal_input_data_out_change;
      sig_data_out_local = sig_data_out_in;
   end
   
   always @(sig_acknowledgement_in) begin
      if (sig_acknowledgement_local != sig_acknowledgement_in)
         -> signal_input_acknowledgement_change;
      sig_acknowledgement_local = sig_acknowledgement_in;
   end
   


// synthesis translate_on

endmodule

