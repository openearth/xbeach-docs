Cloud computing with XBeach
===========================

*by Marco Westra MetOcean Consult*

In this tutorial discusses the possibilities of `cloud computing` for
XBeach (Roelvink et al., 2009) on two different cloud computing
systems is presented. Cloud computing is a web service that provides
resizable compute capacity in the cloud. A simple web service
interface allows the user to obtain and configure capacity with
minimal friction. Cloud computing reduces the time required to obtain
and boot new machine to minutes, allowing the user to quickly scale
capacity, both up and down, as your computing requirements change.

The cloud computing systems analysed in this memo are Amazon EC2
(Chapter 2) and Microsoft Azure (Chapter 3). The focus of this
analysis is to identify the possibilities per system and to determine
the best option in terms of price per XBeach simulation. This analysis
is carried out for WP5 (Application at case studies sites) within the
RISC-KIT program in order to provide partners that do not have high
speed computational facilities with an alternative. The conclusions
are presented in Chapter 4.

Amazon EC2
----------

Amazon offers via AWS (Amazon Web Services) several possibilities of
cloud computing (EC2: Elastic Compute Cloud). The possibilities of the
on-demand instances are tested. There are however also possibilities
with so-called reserved instances. This can potentially save up to 75%
in prices, but doesn't have the flexibility of the on-demand
services.  An `Instance` is the name for a computer / virtual
machine. In this memo the possibilities of the UNIX-environment
(Linux) are tested.

More information about the cloud computing possibilities of Amazon can
be found on their website: http://aws.amazon.com/ec2/.

Creating an account
^^^^^^^^^^^^^^^^^^^

Creating an account at Amazon is quite easy. On top of that there is a
free tier that is designed to enable to get hands-on experience with
AWS at no charge for 12 months after you sign up.  After creating your
AWS account you can use any of the 21 products and services (EC2 is
one of them). You can sign up for the AWS's free tier with the
following steps:

* Sign-up for an AWS account.
* Enter your billing address and credit card information. You will not
  be charged unless your usage exceeds the free usage tiers.
* Start using AWS choosing from any of the products listed below.
* For XBeach simulations you need to select the `Amazon EC2`

.. code-block:: text

   dummy bla bla 
