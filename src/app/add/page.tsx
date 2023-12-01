"use client";

import { useSession } from "next-auth/react";
import Image from "next/image";
import { useRouter } from "next/navigation";
import React, { useState, useEffect } from "react";
import {
    getStorage,
    ref,
    uploadBytesResumable,
    getDownloadURL,
} from "firebase/storage";
import { app } from "@/app/utils/firebase";


type Inputs = {
    title: string;
    desc: string;
    price: number;
    catSlug: string;
};

type Option = {
    title: string;
    additionalPrice: number;
};

const AddPage = () => {
    const { data: session, status } = useSession();
    // console.log(">>>check status: ", status);
    // console.log(">>>check data: ", session);
    const [inputs, setInputs] = useState<Inputs>({
        title: "",
        desc: "",
        price: 0,
        catSlug: "",
    });

    const [option, setOption] = useState<Option>({
        title: "",
        additionalPrice: 0,
    });

    const [options, setOptions] = useState<Option[]>([]);
    const [file, setFile] = useState<File | null>();

    const [media, setMedia] = useState("");

    const router = useRouter();

    useEffect(() => {
        const storage = getStorage(app);
        const upload = () => {
            if (file) {
                const name = new Date().getTime() + file.name;
                const storageRef = ref(storage, name);

                const uploadTask = uploadBytesResumable(storageRef, file);

                uploadTask.on(
                    "state_changed",
                    (snapshot) => {
                        const progress =
                            (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
                        console.log("Upload is " + progress + "% done");
                        switch (snapshot.state) {
                            case "paused":
                                console.log("Upload is paused");
                                break;
                            case "running":
                                console.log("Upload is running");
                                break;
                        }
                    },
                    (error) => { },
                    () => {
                        getDownloadURL(uploadTask.snapshot.ref).then((downloadURL) => {
                            setMedia(downloadURL);
                        });
                    }
                );
            }

        };
        file && upload();
        // console.log(">>>check file: ", file)
    }, [file]);

    useEffect(() => {
        if (status === "unauthenticated" || session?.user.isAdmin === false) {
            router.push("/");
        }
    }, [status, session]);

    const handleChange = (
        e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
    ) => {
        setInputs((prev) => {
            return { ...prev, [e.target.name]: e.target.value };
        });
    };
    const changeOption = async (e: React.ChangeEvent<HTMLInputElement>) => {
        setOption((prev) => {
            return { ...prev, [e.target.name]: e.target.value };
        });
        // let optionTemp = JSON.parse(JSON.stringify(option))
        // optionTemp[e.target.name] = e.target.value
        // console.log(">>> check optionTemp:", optionTemp)
        // await setOption(Object.assign(optionTemp))

    };

    const handleSubmit = async () => {
        // console.log(">>>check handleSubmit: ", media, options, inputs)
        // return
        try {
            const res = await fetch("http://localhost:3000/api/products", {
                method: "POST",
                body: JSON.stringify({
                    img: media,
                    ...inputs,
                    options,
                }),
            });

            const data = await res.json();
            router.push(`/product/${data.id}`);
        } catch (err) {
            console.log(err);
        }
    };

    if (status === "loading") {
        return <p>Loading...</p>;
    }

    return (
        <div className="p-4 lg:px-20 xl:px-40  flex items-center justify-center text-red-500">
            <div className="flex flex-wrap gap-6">
                <h1 className="text-4xl mb-2 text-gray-300 font-bold">
                    Add New Product
                </h1>
                <div className="w-full flex flex-col gap-2 ">
                    <label
                        className="text-sm cursor-pointer flex gap-4 items-center"
                        htmlFor="file"
                    >
                        <Image src="/upload.png" alt="" width={30} height={20} />
                        <span>Upload Image</span>
                    </label>
                    <input
                        type="file"
                        onChange={(e) => {
                            e.target.files && setFile(e.target.files[0])
                        }}
                        id="file"
                        className="hidden"
                    />
                </div>
                <div className="w-full flex flex-col gap-2 ">
                    <label className="text-sm">Title</label>
                    <input
                        className="ring-1 ring-red-200 p-4 rounded-sm placeholder:text-red-200 outline-none"
                        type="text"
                        placeholder="Bella Napoli"
                        name="title"
                        onChange={handleChange}
                    />
                </div>
                <div className="w-full flex flex-col gap-2">
                    <label className="text-sm">Description</label>
                    <textarea
                        rows={3}
                        className="ring-1 ring-red-200 p-4 rounded-sm placeholder:text-red-200 outline-none"
                        placeholder="A timeless favorite with a twist, showcasing a thin crust topped with sweet tomatoes, fresh basil and creamy mozzarella."
                        name="desc"
                        onChange={handleChange}
                    />
                </div>
                <div className="w-full flex flex-col gap-2 ">
                    <label className="text-sm">Price</label>
                    <input
                        className="ring-1 ring-red-200 p-4 rounded-sm placeholder:text-red-200 outline-none"
                        type="number"
                        step="0.1"
                        placeholder="29"
                        name="price"
                        onChange={handleChange}
                    />
                </div>
                <div className="w-full flex flex-col gap-2 ">
                    <label className="text-sm">Category</label>
                    <input
                        className="ring-1 ring-red-200 p-4 rounded-sm placeholder:text-red-200 outline-none"
                        type="text"
                        placeholder="pizzas"
                        name="catSlug"
                        onChange={handleChange}
                    />
                </div>
                <div className="w-full flex flex-col gap-2">
                    <label className="text-sm">Options</label>
                    <div className="flex">
                        <input
                            className="ring-1 ring-red-200 p-4 rounded-sm placeholder:text-red-200 outline-none"
                            type="text"
                            placeholder="Title"
                            name="title"
                            onChange={changeOption}
                        />
                        <input
                            className="ring-1 ring-red-200 p-4 rounded-sm placeholder:text-red-200 outline-none"
                            type="number"
                            step="0.1"
                            placeholder="Additional Price"
                            name="additionalPrice"
                            onChange={changeOption}
                        />
                        <button
                            className="bg-gray-500 p-2 text-white"
                            onClick={() => setOptions((prev) => [...prev, option])}
                        // onClick={() => setOptions([...options, ...[option]])}
                        >
                            Add Option
                        </button>
                    </div>
                    <div className="flex flex-wrap gap-4 mt-2">
                        {options.length > 0 && options.map((opt) => (
                            <div
                                key={opt.title}
                                className="p-2  rounded-md cursor-pointer bg-gray-200 text-gray-400"
                                onClick={() =>
                                    setOptions((prev) =>
                                        prev.filter((item) => item.title !== opt.title)
                                    )
                                }
                            >
                                <span>{opt.title}</span>
                                <span className="text-xs"> (+ ${opt.additionalPrice})</span>
                            </div>
                        ))}
                    </div>
                </div>
                <button
                    // type="submit"
                    onClick={handleSubmit}
                    className="bg-red-500 p-4 text-white w-48 rounded-md relative h-14 flex items-center justify-center"
                >
                    Submit
                </button>
                <div style={{ height: 1, width: "100%", backgroundColor: "#ffcfcf" }}></div>
            </div>

        </div>
    );
};

export default AddPage;