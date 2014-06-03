From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: kvm_entry dynamic probes
Date: Tue, 03 Jun 2014 10:49:48 -0400
Message-ID: <538DE08C.3020101__30959.0937024497$1401807059$gmane$org@efficios.com>
References: <CA+=dQ-_v7N4DwNmaEFuLMZQ2pdQAYtdvLEDpwk8mZ5pHTy-PPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([85.12.144.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1Wrq2I-0008Gn-8X
 for lttng-dev@lists.lttng.org; Tue, 03 Jun 2014 10:50:03 -0400
In-Reply-To: <CA+=dQ-_v7N4DwNmaEFuLMZQ2pdQAYtdvLEDpwk8mZ5pHTy-PPw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Divya Vyas <dvyas@mvista.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

On 14-06-02 05:29 AM, Divya Vyas wrote:
> Hi,
> 
> I am getting this error while adding dynamic probe to kvm_entry
> 
> Command to change state of events failed
> Command failed! Command:  lttng enable-event entry -k  -s probes
> --function kvm_entry
> Return Value: 4
> Error: Event entry: Enable kernel event failed (channel channel0,
> session probes)
> Warning: Some command(s) went wrong
> 
> while same I did for kvm_exit and it works . I am using lttng 2.3.1

The kvm_entry function does not exist in the kernel because it is arch
dependant. You can use vcpu_enter_guest on x86 or
kvm_arch_vcpu_ioctl_run on arm to have what you are looking for.

I grepped "trace_kvm_entry" in the kernel source tree to find this
information.

I hope this helps,

Julien
