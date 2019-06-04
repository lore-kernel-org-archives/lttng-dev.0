From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Need help in converting trace data into CTF
Date: Tue, 4 Jun 2019 10:53:12 -0400
Message-ID: <20190604145312.GB13240__14702.8134715342$1559660010$gmane$org@joraj-alpa>
References: <CAEWVvOSE6QJQvQEdTLEhNQTE7H1Py1ggoqynSj3w-uOYBkTMCQ@mail.gmail.com>
 <72388180.2647.1558032721255.JavaMail.zimbra@efficios.com>
 <CAEWVvOS6WyAkE+5GAyn_WEoFW_6h_fWbze-im0w7oqvXS-+dBw@mail.gmail.com>
 <1448366760.18406.1559146893765.JavaMail.zimbra@efficios.com>
 <CAEWVvOSdmSsfGiN2fd7yAO6m5-Ke=GuamNR6jKYCLRnSym9Hcw@mail.gmail.com>
 <CAEWVvOSorZyz=JOaf-7go-EyZxcmiOzcVbnUpb7crdKM_SVejA@mail.gmail.com>
 <20190604143917.GA13240@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45JFKR2R8TzyVT
 for <lttng-dev@lists.lttng.org>; Tue,  4 Jun 2019 10:53:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20190604143917.GA13240@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Ravindra Kumar Meena <rmeena840@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> See this dmesg source plugin for a base example of a source plugin [1]. This is
> valid for babeltrace 2.0 only (AKA the current master branch of babeltrace)
> 
> For a more complete example of a source plugin,  you can take a look at the one for
> ctf [2]. Once a source plugin is done you will be able to reuse all the current
> infrastructure of babeltrace to output to ctf (ctf.sink).
> 
> There is no magic solution here, you will need to write a decoder (source
> plugin) for your format.
> 
> [1] https://github.com/efficios/babeltrace/tree/master/plugins/text/dmesg

For all the people coming here from the future:

[1] http://git.efficios.com/?p=babeltrace.git;a=tree;f=plugins/text/dmesg;h=a45918aaf266dac29db6f7a0e4d08ffdb056131a

> [2] https://github.com/efficios/babeltrace/tree/master/plugins/ctf/fs-src

[2] http://git.efficios.com/?p=babeltrace.git;a=tree;f=plugins/ctf/fs-sink;h=b96b435706cac0ed50cb64918603172b67afc424
