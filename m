From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] Introduce RCU-enabled DQs (v2)
Date: Tue, 27 Aug 2013 00:23:16 +0200
Message-ID: <521BD554.4010806@redhat.com>
References: <1377371209-2017-1-git-send-email-ncmike@ncultra.org>
	<20130825191835.GA1073@Krystal>
	<CAGaKXu1V5Cz+9b=v=HEt2kn=2sJiD+ORm_9SyB7v35zNXWWUOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <CAGaKXu1V5Cz+9b=v=HEt2kn=2sJiD+ORm_9SyB7v35zNXWWUOw@mail.gmail.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Mike Day <ncmike@ncultra.org>
Cc: rp@svcs.cs.pdx.edu, qemu-devel@nongnu.org, lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Anthony Liguori <anthony@codemonkey.ws>, Paul Mckenney <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Il 26/08/2013 23:48, Mike Day ha scritto:
> 
> 
> Mathieu - Thanks for the review! And thanks for the code, I'm working
> with it right now. I like the idea of using a flag to provide a form of
> atomicity for the doubly-linked list elements. I'm also planning on
> running some timing tests to see of the additional memory barriers and
> atomic accesses make *any* difference whatsoever. 

We probably have already too many queue/list variations (a relic of the
BSD queue.h headers).  Linux does not need RCU-friendly reverse
iteration at all, do we really need it?  In other words, I think your v2
was really close to mergeable state...

Paolo
