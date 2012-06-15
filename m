From: "Oestman, Fredrik" <Fredrik_Oestman@mentor.com>
Subject: Prerequsites for adding perf context
Date: Fri, 15 Jun 2012 08:23:51 +0000
Message-ID: <524C960C5DFC794E82BE548D825F05CF283461BF__46454.1437374011$1339748660$gmane$org@EU-MBX-01.mgc.mentorg.com>
References: <1339746088.90723.YahooMailNeo@web161201.mail.bf1.yahoo.com>
	<4FDAEF5C.9030102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Fredrik_Oestman@mentor.com>) id 1SfRp2-0006aO-Im
	for lttng-dev@lists.lttng.org; Fri, 15 Jun 2012 04:24:00 -0400
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1SfRov-0001ke-P4 from Fredrik_Oestman@mentor.com
	for lttng-dev@lists.lttng.org; Fri, 15 Jun 2012 01:23:53 -0700
In-Reply-To: <4FDAEF5C.9030102@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,


What exactly is needed on a system for

# lttng add-context -k -t perf:<something>

to work? Does perf have to be installed?

I have hw perfevents, but not perf, and get

hw perfevents: unable to reserve pmu


cheers,

Fredrik =D6stman
