From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Mariadb+LTTng 2.x
Date: Wed, 22 May 2013 08:54:29 -0400
Message-ID: <20130522125429.GD1203__27845.540669705$1369227308$gmane$org@Krystal>
References: <5196A107.7070706@voxpopuli.im>
	<8E0A14A4C9B95B459AE214584119C1EB417EFD06@tulip.ad.unb.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Uf8Yp-0000hm-24
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 08:54:31 -0400
Content-Disposition: inline
In-Reply-To: <8E0A14A4C9B95B459AE214584119C1EB417EFD06@tulip.ad.unb.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yang Wang <yangw.wang5@unb.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Graeme Johnson <Graeme_Johnson@ca.ibm.com>, Kenneth Kent <ken@unb.ca>, Yannick Brosseau <yannick.brosseau@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

Ensure that you don't have a old sessiond binary still running,

that you issue ldconfig as root,

that you don't have stale old libs in /usr/lib nor /usr/local/lib

Thanks,

Mathieu

* Yang Wang (yangw.wang5@unb.ca) wrote:
> Hello Alex,
> 
> I reinstalled lttng-tools-2.1.0 and compiled Mariadb with lttng-ust.2.1.2(now they work together)
> The following is related to lttng-tools-2.1.0 in /usr/local/lib after I reinstalled it.
> 
> -rw-r--r-- 1 root root  1018130 May 18 13:50 liblttng-ctl.a
> -rwxr-xr-x 1 root root     1035 May 18 13:50 liblttng-ctl.la
> lrwxrwxrwx 1 root root       21 May 18 13:50 liblttng-ctl.so -> liblttng-ctl.so.0.0.0
> lrwxrwxrwx 1 root root       21 May 18 13:50 liblttng-ctl.so.0 -> liblttng-ctl.so.0.0.0
> -rwxr-xr-x 1 root root   491876 May 18 13:50 liblttng-ctl.so.0.0.0
> 
> But it reports the same error as before. If it is a compatibility problem, why my instrumented
> J9 VM with lttng-ust.2.1.2 has no this errors? 
> 
> Yang
> 
> ________________________________________
> From: Alexandre Montplaisir [alexmonthy@voxpopuli.im]
> Sent: Friday, May 17, 2013 6:28 PM
> To: Yang Wang
> Cc: Mathieu Desnoyers; Yannick Brosseau; David Goulet; Graeme Johnson; Kenneth Kent; lttng-dev@lists.lttng.org
> Subject: Re: Mariadb+LTTng 2.x
> 
> Hi Yang,
> 
> On 13-05-17 05:21 PM, Yang Wang wrote:
> > It seems not this compatibility problem. I have removed all ust1.0 stuffs in the instrumented Mariadb code and
> > replaced with lttng-ust 2.x say, tracepoint statements, trancepoint provider files, probes files and use the lib -llttng-ust instead of -lust. Anything I missed?
> 
> Mathieu was talking about 2.0 vs 2.1, not 0.x vs 2.x.
> 
> If you compiled your application with lttng-ust 2.1, make sure you use
> lttng-tools 2.1 to trace it. lttng-tools 2.0 will not work.
> 
> >
> > Is "libust[7848/7853]: " reported from lttng-tools 2.0? Actually, this is printed from
> 
> Yeah I think this is normal, this is old stuff that dates from the 0.x
> days, but lttng-ust still prints it that way.
> 
> 
> Cheers,
> Alex
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
