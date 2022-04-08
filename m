Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC713C433F5
	for <lttng-dev@archiver.kernel.org>; Fri,  8 Apr 2022 16:30:37 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KZkJD0jXHz36H;
	Fri,  8 Apr 2022 12:30:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1649435436;
	bh=XxkCvZAFEP8LYVHe31uNr/K3RSwMtPSSFgwlIDf1hH8=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ZPbU4i7Z14cW0r880dah10wXsg2cT7aGu/SxNJ/gntTCTsBE0FZ37ZrW81ceOmbjm
	 D9vJW/nKNpxNenQSDVIRCfwIMUH9JVdLz+y1prNZ9x6rQt6oFRNtXhSWCUBQvWJpeo
	 hv5BdR4nqJQLhmCI+f4+CRRbpRyRD8a1FN1cNF9BvXqpQjkM6q0U0oH9bGR3GPN6+j
	 WX82qa7bEzS58p7zMcrnVo9vSXyDGySxgAmiwzzjcKvAKvtgKJkfp+7YN6T+P+tsIx
	 5iDScSZRvffwFkR4C4dT8YNz1ChLC4pe9qlRJ+yjFyOWWSISq4PpOQ0fo7K8Wu4cDv
	 aESls4HrWLjXw==
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KZkJB1pnfz3NC
 for <lttng-dev@lists.lttng.org>; Fri,  8 Apr 2022 12:30:34 -0400 (EDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-sLbfmK56McatYk0pujSh1w-1; Fri, 08 Apr 2022 12:24:08 -0400
X-MC-Unique: sLbfmK56McatYk0pujSh1w-1
Received: by mail-wr1-f71.google.com with SMTP id
 l22-20020adfa396000000b0020612097035so2357340wrb.8
 for <lttng-dev@lists.lttng.org>; Fri, 08 Apr 2022 09:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=WNM3e13FuXjpOTxfKn23ludDa/hElwvCWDA3XWMySmQ=;
 b=e+1mswPEfUMoYIlHqizFOxvmmVOWHSkUYt9wqkrD4A/Y2MndYHccf41/MrEdAyaLyd
 ULfmwh1JG5EBIo/JJW5Ac8RQrzVvkNjW2sYlAPq/M2djhCSvIOsG+NQ9+CLMG51MlHNC
 e+njrAyKSVzZXWZ0xChRcSjlQbHiCXclAhsPokqRfcFpIr3bi2Fo0SzZuLuZ7Gx5BsEd
 GR/NG3OqIljoTi87mgoXETPITef2R2C64u8smvU8azMHYP17rnPLmyR76iqU6qAW2ZYZ
 JNAcj5Nqq+yRw2G+BZcu/EmK8Ag0DYeGReKrj4k8wxGSZ3Ti9BqOzmu+wW3i4Bpxb6IF
 F9jA==
X-Gm-Message-State: AOAM530QrLwtoB3zGmHluwU1XepFo49jBuO/oQpO3LxjjmKbw6nJfLGT
 bfm8l7Xg0Utm1K+umoX8mvmHxQWzueYghmbPgombgN9dy2mBV6159EVXv5dqIwWRIdh9HT+OuEP
 H1YFcFBPAC58yEcDbYRcW
X-Received: by 2002:adf:eb88:0:b0:205:e113:dcb5 with SMTP id
 t8-20020adfeb88000000b00205e113dcb5mr15157605wrn.598.1649435047338; 
 Fri, 08 Apr 2022 09:24:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSxPKbVuvV53Om6MJ+HAp3TS7BkfNNmVWZgz1Pz7A94FNoiFZRaEs/aLh1XXt0q8y0d21VhA==
X-Received: by 2002:adf:eb88:0:b0:205:e113:dcb5 with SMTP id
 t8-20020adfeb88000000b00205e113dcb5mr15157592wrn.598.1649435047094; 
 Fri, 08 Apr 2022 09:24:07 -0700 (PDT)
Received: from [10.32.181.87] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.googlemail.com with ESMTPSA id
 j16-20020a05600c191000b0038ca3500494sm16631476wmq.27.2022.04.08.09.24.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Apr 2022 09:24:06 -0700 (PDT)
Message-ID: <3c11308e-006a-a7e9-8482-c6b341690530@redhat.com>
Date: Fri, 8 Apr 2022 18:24:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sean Christopherson <seanjc@google.com>
References: <1218866473.10909.1649432186473.JavaMail.zimbra@efficios.com>
In-Reply-To: <1218866473.10909.1649432186473.JavaMail.zimbra@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Subject: Re: [lttng-dev] Unexport of kvm_x86_ops vs tracer modules
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Paolo Bonzini via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Paolo Bonzini <pbonzini@redhat.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, rostedt <rostedt@goodmis.org>,
 kvm@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 4/8/22 17:36, Mathieu Desnoyers wrote:
> LTTng is an out of tree kernel module, which currently relies on the export.
> Indeed, arch/x86/kvm/x86.c exports a set of tracepoints to kernel modules, e.g.:
> 
> EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_entry)
> 
> But any probe implementation hooking on that tracepoint would need kvm_x86_ops
> to translate the struct kvm_vcpu * into meaningful tracing data.
> 
> I could work-around this on my side in ugly ways, but I would like to discuss
> how kernel module tracers are expected to implement kvm events probes without
> the kvm_x86_ops symbol ?

The conversion is done in the TP_fast_assign snippets, which are part of 
kvm.ko and therefore do not need the export.  As I understand it, the 
issue is that LTTng cannot use the TP_fast_assign snippets, because they 
are embedded in the trace_event_raw_event_* symbols?

We cannot do the extraction before calling trace_kvm_exit, because it's 
expensive.

Paolo

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
