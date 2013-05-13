From: Jan Glauber <jan.glauber@gmail.com>
Subject: Re: [RFC PATCH 0/2] babeltrace legacy LTT 2.6 converter
Date: Mon, 13 May 2013 12:40:53 +0200
Message-ID: <20130513104051.GA2802__35120.6974396065$1368441693$gmane$org@hal>
References: <CAKL3bWXEDr-YBPg-H+yZNQxPzh3qqjdRMSJNR9t8ehXP4KS_0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jan.glauber@gmail.com>) id 1UbqBj-00053h-3O
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 06:41:03 -0400
Received: by mail-ea0-f172.google.com with SMTP id d10so356204eaj.3
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 03:40:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKL3bWXEDr-YBPg-H+yZNQxPzh3qqjdRMSJNR9t8ehXP4KS_0A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anna Dushistova <anna.dushistova@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Mon, May 13, 2013 at 10:16:04AM +0400, Anna Dushistova wrote:
> Hi Jan,
> 
> I tried out your patch for the 2.6->ctf converter(
> http://lists.lttng.org/pipermail/lttng-dev/2013-April/020081.html)
> with the following trace:
> https://github.com/fchouinard/LTTng/blob/master/samples/trace-2.6-22K.tar.gz
> 
> from
> http://wiki.eclipse.org/Linux_Tools_Project/LTTng/User_Guide#Downloading_Sample_Tracesand
> it crashed
> with segmentation fault.

Hi Anna,

could it be that the tar file itself is in the trace directory when you run babeltrace-legacy?
I think I've only implemented rudimentary file checking, so the legacy converter assumes
all files in the directory belong to the trace. Please try removing any files that do not belong
to the trace.

That said, the converter should better check all files for the correct header...

Regards, Jan
 
> Anna.

-- 
Jan Glauber
---
Harman Becker Automotive GmbH
System Profiling & Optimizing Team
