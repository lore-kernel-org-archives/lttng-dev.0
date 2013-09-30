From: Mohamad Gebai <mohamad.gebai@polymtl.ca>
Subject: Re: [lttng-dev] [PATCH] trace: drop LTTng Userspace
	Tracer backend
Date: Mon, 30 Sep 2013 19:21:35 -0400
Message-ID: <524A077F.6090307@polymtl.ca>
References: <1380101319-29435-1-git-send-email-stefanha@redhat.com>
	<52431092.7040109@polymtl.ca>
	<20130926080121.GD24531@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20130926080121.GD24531@stefanha-thinkpad.redhat.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: lttng-dev@lists.lttng.org, =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, =?ISO-8859-1?Q?Llu=EDs_Vilanova?= <vilanova@ac.upc.edu>
List-Id: lttng-dev@lists.lttng.org

Hi Stefan,
Sorry for the delay but I rewrote all the patches to make the merge as
non-intrusive as possible, which wasn't the case in the patches I wrote 
for my
personal use.
I submitted them in a different thread on the mailing list.

Mohamad

On 13-09-26 04:01 AM, Stefan Hajnoczi wrote:
> On Wed, Sep 25, 2013 at 12:34:26PM -0400, Mohamad Gebai wrote:
>> I am actually using LTTng 2.x as a backend for UST to do some
>> performance analysis and latency investigation using Qemu/KVM. I
>> already have all the patches ready to replace the old 0.x interface,
>> and I am preparing them for the merge upstream.
> Excellent, I was hoping to find someone who wants to update the code.
>
> Do you need the old 0.x code for your patches or is it cleaner if we
> apply my patch to drop that first?  I guess you pretty much rewrote
> the ./configure and tracetool pieces...
>
> Stefan
