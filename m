From: Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: LTTng UST vs Syslog, Printf...
Date: Wed, 21 Aug 2013 11:07:00 -0400 (EDT)
Message-ID: <1243842901.524675.1377097620865.JavaMail.root__13522.8052073673$1377097679$gmane$org@polymtl.ca>
References: <63008C666A72BB4F892767155D012B30114CDB91@eusaamb105.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <michel.dagenais@polymtl.ca>) id 1VCA00-00085v-92
	for lttng-dev@lists.lttng.org; Wed, 21 Aug 2013 11:07:09 -0400
In-Reply-To: <63008C666A72BB4F892767155D012B30114CDB91@eusaamb105.ericsson.se>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jim Dumont <jim.dumont@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

 
> I would suggest something relatively simple and basic as far as
> performance & characteristics measurements goes - x apps, y traces /
> second - measure CPU, memory, i/o, file size across the various
> mechanisms.

Yes, something relatively simple should do. For a process writing to syslog, you get a system call, two context switches and a number of other things, as compared to simply writing a few bytes in memory. And you should probably not try to benchmark printk by recording all system calls using it, your kernel will burst.
