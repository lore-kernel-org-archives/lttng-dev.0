From: David Goulet <david.goulet@polymtl.ca>
Subject: Re: [lttng-tools PATCH] lttng-tools python module
Date: Wed, 01 Aug 2012 12:02:30 -0400
Message-ID: <50195316.6070606__22850.0822363005$1343836983$gmane$org@polymtl.ca>
References: <1343326167-11522-1-git-send-email-danny.serres@efficios.com>
	<50182739.3030604@polymtl.ca> <50182FEF.6070504@gmail.com>
	<501936F6.7010800@polymtl.ca>
	<CAGDH53mt0N1BiqL3opx8Mh6rkS78ndzAnak7G742xQVeur-YGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <david.goulet@polymtl.ca>) id 1SwbNZ-00010b-Pi
	for lttng-dev@lists.lttng.org; Wed, 01 Aug 2012 12:02:34 -0400
In-Reply-To: <CAGDH53mt0N1BiqL3opx8Mh6rkS78ndzAnak7G742xQVeur-YGw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I agree with that.

The main reason for extras/ is the fact that, for now, this lib would not be
supported meaning that if liblttng-ctl changes, these bindings will NOT follow
it unless someone submit a patch. If we decide at some point to fully support
it, I have no problem seeing it in src/

Cheers!
David

On 01/08/12 11:13 AM, Christian Babeux wrote:
>> - From my point of view, I'm not sure it is, for now, a good idea since
>> it adds a considerable amount work to fully support (at least on my side)
>> a library that is an extra functionality and for that I see this in
>> extras/ for now.
> 
> +1 for extras. I suggest extras/bindings/swig/python. The Apache Subversion
> project has a similar tree [1].
> 
> Christian
> 
> [1] -
> http://svn.apache.org/repos/asf/subversion/trunk/subversion/bindings/swig/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJQGVMWAAoJEELoaioR9I02m7gH/2cnsQ4x4fmdmKKy422l7e9c
8mzsgkWR2NsJHF7d0E7lvg0Be8nsxq59FD0xvN1jqoh4I+aeMt+0Ulz/Z4Gr6c3U
gXLRjDPGyIrkGdL/bFase6WZQKHtvI+6sDIgxDj0TbSjeZ0YOOaAASP6eFTOaWF1
DhyJBtkIIVb8pjU8dYMMWFSkFhlGpCYDangnx09OSY15+AiLQIYd1HJdZoDHwfjP
M9V3cPEqvDFmc4H0qkgX4g5ACN8XlvSN2TZGimDo7KP8qMSRtBxTEy8GrOwXMi+O
pdNVu1gk+f0tAwTFCPGSAXFCv2/B4/wDnBTvu/m06p/NB5sihsskdv3rXK3o4DQ=
=VL+7
-----END PGP SIGNATURE-----
