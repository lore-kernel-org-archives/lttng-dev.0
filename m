From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 2/5] Tests: Add a health check
 utility program
Date: Thu, 27 Sep 2012 16:56:20 -0400
Message-ID: <5064BD74.8000402__635.732574346726$1348779418$gmane$org@efficios.com>
References: <1348770199-1618-1-git-send-email-christian.babeux@efficios.com>
	<1348770199-1618-2-git-send-email-christian.babeux@efficios.com>
	<20120927194538.GB1827@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1THL8C-0004dO-Fy
	for lttng-dev@lists.lttng.org; Thu, 27 Sep 2012 16:56:24 -0400
In-Reply-To: <20120927194538.GB1827@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

<Mathieu Desnoyers:
> * Christian Babeux (christian.babeux@efficios.com) wrote:
>> The health_check program is a simple utility to query the health 
>> status of the different threads of the sessiond.
> 
> do we want to call it lttng-health-check and install it in the
> system ?
> 

We could but I would really prefer add a "lttng health" that calls
this or merge it as a lttng command. I'm no fan of multiplying
binaries :).

David

> Mathieu
> 
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQZL1xAAoJEELoaioR9I02wbgH/j/Qs0my1MzvVvOWtmph08Ll
UKfpGFOXsyHgl96dKNuTzqQ8iSZIDHULCkwHCMDCkRRLiXJ7pyCGN/GkU1oCvLmD
Rc+nfs2MotUZtoqD1NicCUf2d8VIc37pKU0ImeDZMuWk+3lUIqY1//gcUsVdAYJL
18fkIo5ywr7oIdaZdKTRAuXI0ZesZuChpT7mltbcfnfHAp8viIzvPKuvr48V10sE
/jVyYM5tvPvAoCfO15uosTV+m9+/R2taxF1E+Ng5obZtWUurRCPqw28tOW+W9hq4
+Lbwg814ePsVDfOItBjxwXiWhuElGP6SnizD+yUB7ca7Eadcq/Yodb9DvayAtQk=
=4p87
-----END PGP SIGNATURE-----
