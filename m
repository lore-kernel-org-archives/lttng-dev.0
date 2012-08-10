From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 0/2] relayd IPv6 fixes
Date: Fri, 10 Aug 2012 16:36:59 -0400
Message-ID: <502570EB.8080303__4476.54915410585$1344631112$gmane$org@efficios.com>
References: <1344619372-21976-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Szvx7-0008A2-7o
	for lttng-dev@lists.lttng.org; Fri, 10 Aug 2012 16:37:01 -0400
In-Reply-To: <1344619372-21976-1-git-send-email-christian.babeux@efficios.com>
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

Merged!

Thanks

Christian Babeux:
> Hi all,
> 
> Here are a few fixes to IPv6 support in relayd.
> 
> When trying to start the relayd using an IPv6 address, the relayd 
> simply segfaulted. The first patch fix this issue.
> 
> The second patch fix a wrong domain value used in the socket() call
> for the IPv6 socket causing a "Address family not supported by
> protocol" error when calling bind().
> 
> Thanks,
> 
> Christian
> 
> Christian Babeux (2): Fix: Off by one in lttcomm_sock_domain enum 
> Fix: Wrong domain used when initializing IPv6 sockets
> 
> src/common/sessiond-comm/inet6.c         | 2 +- 
> src/common/sessiond-comm/sessiond-comm.h | 4 ++-- 2 files changed,
> 3 insertions(+), 3 deletions(-)
> 
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQJXDnAAoJEELoaioR9I029KwIALM5s5qYwKhmrMpXxY87VXsV
Bqp7AUi4gDcHCC7oU74kCYG4QDwRhOAmFYAQ43R2PmkydRUemlwHM7emFgCycnJ9
ot5uOBqCZtdnP0BqilFyLldm+a4h/LKCOEEqYlPDJeMRzcnbiKWAexyGsvqow9pi
5QH8jaflXfMWX+LEDRdevVB4lIvuURIPWd7SZuIRqWcxCgC2r921KWhgl7yZQd1R
4hWXeCaVLP6kD98Kzj9D98Ex1cRgEsJPUu79uHKU+mGQaueC9c2J9c/nPbcMs6Bz
lc/WQrGrEhbENgkGu1M0KQ1Iwn5U6XKpacGHAhUrfo+5mlI6iYiT4G/Z7F+09r0=
=VLFk
-----END PGP SIGNATURE-----
