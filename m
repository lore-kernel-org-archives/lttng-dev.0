From: Jan Glauber <jan.glauber@gmail.com>
Subject: Re: [PATCH lttng-modules] Fix: Building the event list
 fails on fragmented memory
Date: Tue, 23 Jun 2015 15:46:39 +0200
Message-ID: <20150623134638.GA3944__22959.4155251563$1435067312$gmane$org@hal>
References: <55755E0D.7010902@leisener.de>
 <1905517223.241.1433920494952.JavaMail.zimbra@efficios.com>
 <557838F1.9020808@leisener.de>
 <1586680029.1815.1434223948187.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1Z7OXJ-0005s3-Iq
 for lttng-dev@lists.lttng.org; Tue, 23 Jun 2015 09:47:04 -0400
Received: by wicnd19 with SMTP id nd19so106706121wic.1
 for <lttng-dev@lists.lttng.org>; Tue, 23 Jun 2015 06:46:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1586680029.1815.1434223948187.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Sat, Jun 13, 2015 at 07:32:28PM +0000, Mathieu Desnoyers wrote:
> ----- On Jun 10, 2015, at 9:17 AM, Martin Leisener martin@leisener.de wrote:
> 
> > Hi Mathieu,
> > 
> > sorry for sending the broken patch, I fell for some "smart" formating of my
> > email client, I cannot utilize it myself the way I send it.
> > Hence I now send the patch again as it was original intended. Sent to myself, I
> > can apply it, so I hope it now works in general as well
> > I examined as recommended diff -urN, it seems the output can be utilized by
> > patch the same way as git diff.
> > Hope it is now received the way I intended.
> 
> Hi Martin,
> 
> I tried you patch on a x86-64 machine (my laptop), and although taking a
> single kernel trace worked fine, it appears to OOPS when I run
> 
> (in lttng-tools)
> cd tests
> ./run.sh root_regression

Hi Mathieu,

can you please share the oops message so I can have a look?

Thanks,
Jan
