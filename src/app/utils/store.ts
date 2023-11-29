import { create } from "zustand";
import { ActionTypes, CartType } from "../types/types";
import { persist } from "zustand/middleware";


const INITIAL_STATE = {
    products: [],
    totalItems: 0,
    totalPrice: 0,
};

export const useCartStore = create(persist<CartType & ActionTypes>((set, get) => ({
    products: INITIAL_STATE.products,
    totalItems: INITIAL_STATE.totalItems,
    totalPrice: INITIAL_STATE.totalPrice,
    addToCart(item) {
        const products = get().products;
        if (products.length === 0) {
            set((state) => ({
                products: [...state.products, item],
                totalItems: +state.totalItems + +item.quantity,
                totalPrice: +state.totalPrice + +item.price,
            }));
        } else {
            const productInState = products.find((product) => product.id === item.id);
            if (productInState) {
                if (!item?.optionTitle) {
                    const updatedProducts = products.map((product) =>
                    (product.id === item.id
                        ? {
                            ...item,
                            quantity: +item.quantity + +product.quantity,
                            price: +item.price + +product.price,
                        }
                        : product
                    ));
                    set((state) => ({
                        products: updatedProducts,
                        totalItems: +state.totalItems + +item.quantity,
                        totalPrice: +state.totalPrice + +item.price,
                    }));
                } else {
                    let flag = false
                    products.forEach(product => {
                        if (item.optionTitle === product.optionTitle) {
                            flag = true
                        }
                    })
                    if (flag) {
                        const updatedProducts = products.map((product) => (
                            (product.optionTitle === item.optionTitle)
                                ?
                                {
                                    ...item,
                                    quantity: +item.quantity + +product.quantity,
                                    price: +item.price + +product.price,
                                }
                                : product
                        ));
                        set((state) => ({
                            products: updatedProducts,
                            totalItems: +state.totalItems + +item.quantity,
                            totalPrice: +state.totalPrice + +item.price,
                        }));
                    } else {
                        set((state) => ({
                            products: [...state.products, item],
                            totalItems: +state.totalItems + +item.quantity,
                            totalPrice: +state.totalPrice + +item.price,
                        }));
                    }

                }
            } else {
                set((state) => ({
                    products: [...state.products, item],
                    totalItems: +state.totalItems + +item.quantity,
                    totalPrice: +state.totalPrice + +item.price,
                }));
            }
        }

        // }
    },
    removeFromCart(item) {
        if (!item?.optionTitle) {
            set((state) => ({
                products: state.products.filter((product) => product.id !== item.id),
                totalItems: state.totalItems - item.quantity,
                totalPrice: state.totalPrice - item.price,
            }));
        } else {
            set((state) => ({
                products: state.products.filter((product) => (
                    product.id !== item.id
                    ||
                    (
                        product.id === item.id
                        &&
                        product.optionTitle !== item.optionTitle
                    )
                )),
                totalItems: state.totalItems - item.quantity,
                totalPrice: state.totalPrice - item.price,
            }));
        }
    },
}), { name: "cart", skipHydration: true }))