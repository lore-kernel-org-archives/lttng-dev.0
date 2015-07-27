From: Chris J Arges <chris.j.arges@canonical.com>
Subject: Re: [PATCH lttng-modules] Fix: disable kvm probe if
 lapic.h isn't found
Date: Mon, 27 Jul 2015 11:09:54 -0500
Message-ID: <55B657D2.2080204__29989.2948977233$1438024682$gmane$org@canonical.com>
References: <1437761939-1782-1-git-send-email-chris.j.arges@canonical.com>
 <293728491.1868.1438012137255.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <chris.j.arges@canonical.com>) id 1ZJkyT-0000Gy-Ow
 for lttng-dev@lists.lttng.org; Mon, 27 Jul 2015 12:09:58 -0400
In-Reply-To: <293728491.1868.1438012137255.JavaMail.zimbra@efficios.com>
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

Mathieu,

I'm testing with Ubuntu Wily using a 4.1 series kernel.

include/kvm/iodev.h is installed by linux-headers with the 4.1 kernel,
and therefore the probe Makefile tries to install the kvm probe, but
then fails to compile because arch/x86/kvm/lapic.h isn't found. All this
obviously works if you point at full sources.

--chris

On 07/27/2015 10:48 AM, Mathieu Desnoyers wrote:
> ----- On Jul 24, 2015, at 2:18 PM, Chris J Arges chris.j.arges@canonical.com wrote:
> 
>> In a typical distribution if just linux-headers is installed, lapic.h will
>> not be installed. We should check if that file exists and not build the module.
> 
> Hi Chris,
> 
> Although this patch looks technically correct, I'd like to understand
> how you triggered this issue in the first place.
> 
> If we look at this Makefile, we skip building KVM probes altogether
> if neither $(srctree)/virt/kvm/iodev.h nor $(srctree)/include/kvm/iodev.h
> are found. AFAIU, none of those headers are installed as linux-headers.
> 
> Which of those headers are found in your distribution headers ? Is it
> due to a modification specific to Ubuntu or is it something that
> appears in mainline kernel ?
> 
> Thanks!
> 
> Mathieu
> 
>>
>> Signed-off-by: Chris J Arges <chris.j.arges@canonical.com>
>> ---
>> probes/Makefile | 5 +++++
>> 1 file changed, 5 insertions(+)
>>
>> diff --git a/probes/Makefile b/probes/Makefile
>> index 0314a5e..cc4c352 100644
>> --- a/probes/Makefile
>> +++ b/probes/Makefile
>> @@ -25,6 +25,8 @@ obj-m += lttng-probe-statedump.o
>> ifneq ($(CONFIG_KVM),)
>> obj-m += lttng-probe-kvm.o
>> ifneq ($(CONFIG_X86),)
>> +kvm_dep_lapic = $(srctree)/arch/x86/kvm/lapic.h
>> +ifneq ($(wildcard $(kvm_dep_lapic)),)
>> kvm_dep = $(srctree)/virt/kvm/iodev.h $(srctree)/include/kvm/iodev.h
>> ifneq ($(wildcard $(kvm_dep)),)
>> CFLAGS_lttng-probe-kvm-x86.o += -I$(srctree)/virt/kvm
>> @@ -40,6 +42,9 @@ obj-m +=  $(shell \
>> else
>> $(warning File $(kvm_dep) not found. Probe "kvm" x86-specific is disabled. Use
>> full kernel source tree to enable it.)
>> endif
>> +else
>> +$(warning File $(kvm_dep_lapic) not found. Probe "kvm" x86-specific is
>> disabled. Use full kernel source tree to enable it.)
>> +endif
>> endif
>> endif
>>
>> --
>> 2.1.4
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
