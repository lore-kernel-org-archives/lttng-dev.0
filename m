From: David Goulet <david.goulet@polymtl.ca>
Subject: Re: [lttng-tools PATCH] lttng-tools python module
Date: Wed, 01 Aug 2012 12:15:45 -0400
Message-ID: <50195631.7000808__19422.8540211499$1343837775$gmane$org@polymtl.ca>
References: <1343326167-11522-1-git-send-email-danny.serres@efficios.com>
	<50182739.3030604@polymtl.ca> <50182FEF.6070504@gmail.com>
	<501936F6.7010800@polymtl.ca>
	<CAGDH53mt0N1BiqL3opx8Mh6rkS78ndzAnak7G742xQVeur-YGw@mail.gmail.com>
	<50195316.6070606@polymtl.ca> <5019555F.9090108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <david.goulet@polymtl.ca>) id 1SwbaP-00017v-Jw
	for lttng-dev@lists.lttng.org; Wed, 01 Aug 2012 12:15:49 -0400
In-Reply-To: <5019555F.9090108@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



On 01/08/12 12:12 PM, Yannick Brosseau wrote:
> 
> On 2012-08-01 12:02, David Goulet wrote:
>> I agree with that.
> 
>> The main reason for extras/ is the fact that, for now, this lib would
> not be
>> supported meaning that if liblttng-ctl changes, these bindings will NOT
> follow
>> it unless someone submit a patch. If we decide at some point to fully
> support If its not supported, maybe we should not put it upstream.
> 

Well I though extras/ was there for that?... the lttng bash completion file is
not supported but upstream...

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJQGVYxAAoJEELoaioR9I02cuoH/3yyF/Kx9Dst3wgeZ3rCJm+L
Mz2YFjju3+L7WmkyqY2uR0n2/+rIGC72rjt6sJmM8OQNTiI0EIhLl8TqVEDmpRut
0GrHPCCD6Si1NNr5kTJAsZ28i6N/zSR5/CoAik6ylo5euZRu2p55RZDqI8U5b3eT
zc6547U+lTE2OU4Rm0f1Gt59pt+fGyTI5NrS7ZSW41/2hmAbAnkgGXX1sTV4emo4
epRdZQMxryngjxLY5Nk11qCAopXsKRJ8OBHw66G0a9RKPrQ7i5Ia73IlhTxyrwzV
0NLdGTW6CuYR3grF2dflcmUVFdKsWr7HITDw5IRYYN/ltuesSNm3HAanhH8uvGM=
=Lh77
-----END PGP SIGNATURE-----
