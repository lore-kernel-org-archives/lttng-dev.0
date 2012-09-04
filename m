From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 0/3] Filter allocation and large
 bytecode fixes
Date: Tue, 04 Sep 2012 11:42:01 -0400
Message-ID: <50462149.4010803__26720.6473894932$1346773353$gmane$org@efficios.com>
References: <1346093301-25274-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1T8vGN-0000ZY-Qq
	for lttng-dev@lists.lttng.org; Tue, 04 Sep 2012 11:42:04 -0400
In-Reply-To: <1346093301-25274-1-git-send-email-christian.babeux@efficios.com>
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
Hash: SHA512

All merged except 2/3.

David

Christian Babeux:
> Hi all,
> 
> While testing the new filtering feature, some issues were
> discovered when generating large bytecode (more than 32768 bytes).
> 
> The first patch fix an issue with the buffer size not being a power
> of 2, thus leading to odd-looking alloc buffer size.
> 
> The second patch is a typo fix.
> 
> The third patch fix an issue when generating a bytecode longer than
> 32768 bytes. The alloc_len of the underlying bytecode buffer was
> artificially limiting the bytecode size to 32768 because its length
> was overflowing the range of 16-bits values.
> 
> Thanks,
> 
> Christian Babeux (3): Fix: Filter bytecode alloc buffer size must
> be a power of 2 Fix: Typo in LTTNG_FILTER_MAX_LEN Fix: Generation
> of bytecode longer than 32768 bytes fails
> 
> src/bin/lttng-sessiond/main.c                      |  2 +- 
> src/common/sessiond-comm/sessiond-comm.h           |  2 +- 
> src/lib/lttng-ctl/filter/filter-bytecode.h         |  2 +- 
> .../filter/filter-visitor-generate-bytecode.c      | 46
> ++++++++++++++++++++-- 4 files changed, 46 insertions(+), 6
> deletions(-)
> 
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQRiFJAAoJEELoaioR9I02CJkIAK17zl/81EYeECRffELtmNDa
KwSLfhPl2Xf0wVPm2TshxLK5Lc3yE/14KYrMbeTP4sYB87Vn66k4HqZIqWHtYtaS
TKI1qjruhuC4LqySHTUcuw4TWC0j96ZoM5iSc97lj9dqCmrRA8A9msnbfssPi/FQ
g6tIsScpozrzHbBNYL9aCBqcrdX60tMm2fZ7XqJZi5f3yy7QNlWKVNWrFWHHxMks
PATSwgQhhyVi8GsZj33n+bMBuiXbMxii1S5h7zVedxCXWdL5w1wtr9l6WmD/l8jw
HUtCS+BWh0Fldh1/M2ua2GyfvAGJuyxJyJPC/jPdYF9dJWf+/3AoWMn6poIbxPA=
=pRxc
-----END PGP SIGNATURE-----
