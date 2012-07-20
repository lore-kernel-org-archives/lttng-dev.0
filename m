From: David Goulet <dgoulet@efficios.com>
Subject: Re: Question about zero metadata
Date: Fri, 20 Jul 2012 10:28:32 -0400
Message-ID: <50096B10.9030808__39304.9506973059$1342794552$gmane$org@efficios.com>
References: <5007D46B.3060205@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1SsEC4-0006mB-QQ
	for lttng-dev@lists.lttng.org; Fri, 20 Jul 2012 10:28:36 -0400
In-Reply-To: <5007D46B.3060205@emc.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: changz <zheng.chang@emc.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Zheng,

In order to be able to read the trace, you have to stop the session
(lttng stop) and a flush is automatically done in the background.

However, reading a trace while it is being created (live reading) is
on the roadmap for LTTng 2.2 or later.

So, for now, you need to start/stop the tracing session.

Thanks!
David

changz:
> Hi all,
> 
> I tried to generate one event and view the trace at run-time. It
> didn't work because metadata was zero. And then I found metadata
> couldn't be dumped to disk when sub-buffer were not filled(i.e.
> consumer daemon didn't read data from ring-buffer). And seems no
> timer to flush it because I waited for very long time. Once I
> stopped lttng or the application, metadata got ready at once.
> 
> My lttng version is 2.01. Is this a known issue?
> 
> Thanks Zheng
> 
> _______________________________________________ lttng-dev mailing
> list lttng-dev@lists.lttng.org 
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQCWsMAAoJEELoaioR9I02DFwH/A6mGfvwOqshhqCspYAsdBev
ZmJ0PsT5q6JqmJcbwasMdH9CgEUBb9Kx+H9Jr8cJNfZLq6mk/sNLvz3CUy1HUsKF
TsAnXImbFs00+mFTE8rn296SXkzfz9boB1ROU9OqDfLJvdNZYSdivCadSBDS9dap
5rrXT5ktILb2h9UoupUqpW9sGZwANmCPuVNnIM2AYBvKFbtqoqWhQldWr8Qg87D3
JdkK+5OFDficGpGUOXhcEoDFzit95TzDYqE6aN7k8TW8H1RrcQ1TPf2bFfO20PZF
T6XFVzkbzmUWvzbVfAIiRC0YtmyTojTn+45htkRF6VVPWQivxVrMq50XUXuzsyo=
=/52f
-----END PGP SIGNATURE-----
