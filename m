From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: [babeltrace] About the type read and write
Date: Thu, 30 Aug 2012 11:11:06 -0400
Message-ID: <503F828A.1070601__25890.7863092192$1346339520$gmane$org@ericsson.com>
References: <CANFwon1jpk3PYYd-ufUSCgKf693vApFgt5UbyOFnPczYTrSZcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr4.ericy.com ([198.24.6.9])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1T76P1-0002NF-DJ
	for lttng-dev@lists.lttng.org; Thu, 30 Aug 2012 11:11:27 -0400
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
	by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id
	q7UFDNcU013706
	for <lttng-dev@lists.lttng.org>; Thu, 30 Aug 2012 10:13:32 -0500
In-Reply-To: <CANFwon1jpk3PYYd-ufUSCgKf693vApFgt5UbyOFnPczYTrSZcQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi, just a heads up, there will be a java version of a ctf writer coming
out _soonish_ within in a couple months.

On 12-08-23 05:35 AM, Hui Zhu wrote:
> Hi,
>
> I just tried to use libbabeltrace to read and write the CTF file.  But
> I cannot find the api to read some type of CTF for example
> CTF_TYPE_ENUM, CTF_TYPE_STRUCT.
> And I cannot find the api file to write to the CTF file. (I check the
> code of babeltrace-log and found that it use the function that is not
> API)
>
> Could you help me with it?
>
> Thanks,
> Hui
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
