From: Charles Briere <c.briere@samsung.com>
Subject: Re: UST tracing problem on ARM/Android
Date: Fri, 23 Jan 2015 19:15:40 +0000
Message-ID: <1422040541.12886.146.camel__25537.0415900417$1422040842$gmane$org@samsung.com>
References: <1421273876.3881.68.camel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout3.w2.samsung.com ([211.189.100.13]
 helo=usmailout3.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1YEjhs-0000cb-LU
 for lttng-dev@lists.lttng.org; Fri, 23 Jan 2015 14:15:49 -0500
Received: from uscpsbgex1.samsung.com
 (u122.gpu85.samsung.co.kr [203.254.195.122]) by usmailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NIN00HIL9I6J010@usmailout3.samsung.com> for
 lttng-dev@lists.lttng.org; Fri, 23 Jan 2015 14:15:42 -0500 (EST)
Received: from sisasmtp.sisa.samsung.com ([105.144.21.115])
 by usmmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-27.01(7.0.4.27.0) 64bit (built Aug
 30 2012)) with ESMTP id <0NIN007CH9I5D620@usmmp2.samsung.com> for
 lttng-dev@lists.lttng.org; Fri, 23 Jan 2015 14:15:41 -0500 (EST)
In-reply-to: <1421273876.3881.68.camel@samsung.com>
Content-language: en-US
Content-id: <F95EEBEECA866E43984E25C3608DABE6@samsung.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

So I just found out why this was hapenning and thought I would share my
findings.

The Android linker will load a shared library twice in memory if it has
a different path (even symbolic link). Therefore when
dl_opening("lttng-ust-tracepoint.so.0", ...), even if that library is
already loaded as it has been defined at link time, it will duplicate
all it's symbols. The function add_calliste will populate the
callsite_table which is local to the dl_open(ed) library while
tracepoint_sync_callsites will try to read an unitialized one, local to
it's own symbols. 

That brings me to ask, why not passing "liblttng-ust-tracepoint.so" to
dl_open()? What is the reason for versioning here as anyway at link
time, liblttng-ust-tracepoint.so is the one beeing used?

Thanks,
Charles

On Wed, 2015-01-14 at 14:17 -0800, Charles Briere wrote:
> Hello world,
> 
> I've been running in some inssues lately with UST on ARM/Android. Using
> the following to configure my session, I enable every ust event.
> 
> lttng create
> lttng enable-event -ua
> 
> Although, when a tracepoint is called, its state ( struct
> lttng_ust_tracepoint -> state) is 0. 
> 
> My understanding of the whole registration process is limited, so the
> following reasoning is probably flawed, so please correct me if that
> happens. 
> 
> I found out, that when registering the library
> (tracepoint_register_lib), callsite_table is populated. But later on
> when it comes to register the probes (lttng_prove_register),
> callsite_table 's address is different and the list is empty. As a
> result, when tracepoint_sync_callsite() is called, set_tracepoint() is
> never executed as looping through an empty list. 
> 
> What I don't understand in here, is that the callsite_table pointer is
> not the same during the lib registration and probe registration. Both
> are ran sequentially in the same thread and I can't figure what other
> operation could affect the variable. Any hint/help would be much
> appreciated.
> 
> Thanks,
> Charles
