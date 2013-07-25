From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: List to insmod lttng modules
Date: Thu, 25 Jul 2013 12:18:11 -0400
Message-ID: <51F14FC3.2020409__28653.2800099396$1374769156$gmane$org@efficios.com>
References: <CAJD=Q56sC911-aY5jQpVDZ4Q-6JoxitEQQDvmp_N5TWfGbtyQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([93.20.26.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1V2OFA-0006Ag-Fw
	for lttng-dev@lists.lttng.org; Thu, 25 Jul 2013 12:18:26 -0400
In-Reply-To: <CAJD=Q56sC911-aY5jQpVDZ4Q-6JoxitEQQDvmp_N5TWfGbtyQg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonnavithula Sharma <sarmajprs@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

When you start lttng-sessiond as root, if the modules are correctly
installed on your system (if modprobe can find them), it should load
them automatically, there is usually no need to load them manually. You
might have to run "depmod -a" after the "make modules_install" in
lttng-modules.

Otherwise, the complete list of modules to load is listed in the source
code of lttng-tools : src/bin/lttng-sessiond/modprobe.c

Hope this helps,

Julien

On 13-07-25 06:30 AM, Jonnavithula Sharma wrote:
> Hi,
> 
> I am using lttng-modules 2.2.1 for the kernel 3.8.13 version and i am
> successful in compiling it and i see there are lot of ".ko" generated in
> probes directory and top level lttng-modules directory.
> 
> So now which module needs to insmod first?Can you provide me the list to
> which module needs to insmod first .
> 
> I tried to insmod some of the .ko i am getting below error.Am i missing
> something here?
> 
> root@ltqcpe:/ramdisk/tmp# insmod lttng-ring-buffer-client-discard.ko
> [94511.780000] lttng_ring_buffer_client_discard: Unknown symbol
> lttng_transport_unregister (err 0)
> [94511.790000] lttng_ring_buffer_client_discard: Unknown symbol
> lttng_transport_register (err 0)
> insmod: can't insert 'lttng-ring-buffer-client-discard.ko': unknown
> symbol in module, or unknown parameter
> 
> 
> Your response is highly aprreciated.
> 
> 
> Thanks & Regards,
> Sarma J
> 
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
